USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spRebate_AretePerformance_replaced011817]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE proc
 [dbo].[spRebate_AretePerformance_replaced011817]
 (
 @PMID Int
 )
 as
 /*
 show both pharmacymaster..v_web_PM_Rebates_APIMonthly.AreteRebateFee
 and pharmacymaster..PM_Rebates_CHAAP.[AretePerformanceRebate]
 rebate month is database month + 2 e.g. 6/1 => August
 BG 7/16
 */
begin
select 
max([Rebate Date]) as [Rebate Date]
,'$' + convert(varchar,cast(round(sum([Arete - AAP Rebate]),2,1) as decimal(38,2))) as [Arete - AAP Rebate]
,'$' + convert(varchar,cast(round(sum([Arete - API Rebate]),2,1) as decimal(38,2))) as [Arete - API Rebate]

from
(
	select top 4
	--datename(month,[date]) + ' ' + convert(varchar(4),year([date])) as [Rebate Date],
	datename(month,dateadd(month,2,[date])) + ' ' + convert(varchar(4),year(dateadd(month,2,[date]))) as [Rebate Date]
	,isnull([AretePerformanceRebate],0.0) as [Arete - AAP Rebate]
	,0.00 as [Arete - API Rebate]
	from
	pharmacymaster..PM_Rebates_CHAAP
	where pmid=@PMID
	and [date] >= '6/1/2016'

UNION

	select top 4
	--datename(month,[date]) + ' ' + convert(varchar(4),year([date])) as [Rebate Date],
	datename(month,dateadd(month,2,[date])) + ' ' + convert(varchar(4),year(dateadd(month,2,[date]))) as [Rebate Date]
	,0.00 as [Arete - AAP Rebate]
	,isnull(AreteRebateFee,0.0) as [Arete - API Rebate]
	from
	pharmacymaster..v_web_PM_Rebates_APIMonthly
	where pmid=@PMID
	and [date] >= '6/1/2016'
) dt
	order by [rebate date] desc
end

/*
select top 1 * from PM_Rebates_APIMonthly

select * from pharmacymaster..[v_web_PM_Rebates_APIMonthly] where AreteRebateFee > 0

100110 both
100125 both
100138 both
100198
100366

select * from pharmacymaster..PM_Rebates_CHAAP where [areteperformancerebate] > 0

100029 AAP only
100071 "
105777
105784
105794

select * from pharmacymaster..[v_web_PM_Rebates_APIMonthly] where date='6/1/2016' and AreteRebateFee > 0
and pmid not in
(select pmid from pharmacymaster..PM_Rebates_CHAAP where date='6/1/2016' and [areteperformancerebate] > 0)

100022 API only
100415
100600
100873
101545

[spRebate_AretePerformance] 100071


*/
GO
