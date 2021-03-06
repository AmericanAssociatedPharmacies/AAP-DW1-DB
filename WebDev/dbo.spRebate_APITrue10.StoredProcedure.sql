USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRebate_APITrue10]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spRebate_APITrue10]
(
	@PMIDList varchar(255)
)
as
/*
new rebate 4/2016 
*/
begin
select 
top 6
datename(month,[date]) + ' ' + convert(varchar(4),year([date])) as [Rebate For],
'$' + convert(varchar(50),round([True10Sales],2,1),-1) as [True 10 Sales],
'$' + convert(varchar(50),round([True10Rebate],2,1),-1) as [Rebate Amount]
--,convert(varchar(50),round([Avg Rebate Percentage]*100.0,2,1)) + '%' as [Rebate Percentage]
--,(select top 1 convert(varchar,PaymentDate,101) from  pharmacymaster..pm_rebates_paymentdates d 
--	where d.RebateMonth=[date] and RebateType='API' order by PaymentDate desc) as [Payment Date**] 

from pharmacymaster..v_web_PM_Rebates_APIMonthly --changed to use view sums multiple api accounts
where pmid in (select * from ufn_CommaListToTable(@PMIDList))
and [date] > '1/1/2016'
order by [date] desc
end

--select * from pharmacymaster..pm_rebates_paymentdates
--grant exec on [spRebate_APITrue10] to webdevuser
GO
