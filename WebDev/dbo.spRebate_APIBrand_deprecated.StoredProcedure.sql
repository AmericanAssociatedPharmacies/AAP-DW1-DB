USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRebate_APIBrand_deprecated]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[spRebate_APIBrand_deprecated]
(
	@PMID int
)
as
begin

select 
top 6
datename(month,[date]) + ' ' + convert(varchar(4),year([date]))  as [Credit For],
'$' + convert(varchar(50),round([API Brand Sales],2,1),-1) as [API Brand Rx Purchases],
'$' + convert(varchar(50),round([Brand Credits Disbursed],2,1),-1) as [API Brand Rx Incentive Credit]

from pharmacymaster..v_web_PM_Rebates_APIMonthly --changed to use view 9/2014, view sums multiple api accounts
where pmid=@PMID

order by [date] desc



end

GO
