USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spReport_RCRebates_step3_Q4APIWH]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spReport_RCRebates_step3_Q4APIWH]
as
-- Report Card Rebates step 3 10/11/10 BG updated 11/11/10 and 11/30/10 and 12/22/10 and 1/26/11 and 2/18/11
-- add pharmacy descriptions and use isnull,0 on all fields
-- excludes affiliates where GR is paid to aff. office
-- excludes 0 totals
-- source: report_RCRebates_Q4APIWH_pivotedData, v_Address_Mailing_Financials, v_PM_AllWithAffiliates
-- output: report_RCRebates_Q4APIWH
begin
drop table reports..report_RCRebates_Q4APIWH
--go

select 
p.Territory as TM,
p.pmid,
p.aapaccountno as [AAP#],
p.aapparentno as [Parent#],
p.apiaccountno as [API#],
CONVERT(VARCHAR(8), p.AAPEffectiveDate, 1)  as [AAP Eff],
CONVERT(VARCHAR(8), p.AAPQuitDate, 1)  as [AAP Quit],
p.AccountDescription as [Description],
p.Affiliate,
p.[accountname] as [Account DBA Name],
p.[corporatename] as [Account Corporate Name],
p.Addr1 as [Address],
p.City, p.State as St,
(select case when p.ownername is null or ltrim(p.ownername)='' then 
	case when (select distinct contactfullname from pharmacymaster..v_Address_Mailing_Financials 
		where pharmacymaster..v_Address_Mailing_Financials.pmid=p.pmid) is null then p.contactfullname
	else (select distinct contactfullname from pharmacymaster..v_Address_Mailing_Financials 
		where pharmacymaster..v_Address_Mailing_Financials.pmid=p.pmid) end
	else p.ownername end ) as Contact,
--from chr mailmerge--case when (p.ownername is null or ltrim(p.ownername)='') then p.contactfullname else p.ownername end as Contact,
case when p.MCQuitDate is null then p.Chaincode else null end as [MC Network],

isnull(r.[PP Rebate 2010Q1],0) as [PP Rebate 2010Q1],
isnull(r.[PP Rebate 2010Q2],0) as [PP Rebate 2010Q2],
isnull(r.[PP Rebate 2010Q3],0) as [PP Rebate 2010Q3],
isnull(r.[PP Rebate 2010Q4],0) as [PP Rebate 2010Q4],
isnull(r.[Total PP Rebate 2010],0) as [Total PP Rebate 2010],
isnull(r.[Q1 API Whse Rebate],0) as [Q1 API Whse Rebate],
isnull(r.[Q1 API Generic Rebate%],0) as [Q1 API Generic Rebate%],
isnull(r.[Q2 API Whse Rebate],0) as [Q2 API Whse Rebate],
isnull(r.[Q2 API Generic Rebate%],0) as [Q2 API Generic Rebate%],
isnull(r.[Q3 API Whse Rebate],0) as [Q3 API Whse Rebate],
isnull(r.[Q3 API Generic Rebate%],0) as [Q3 API Generic Rebate%],
isnull(r.[Q4 API Whse Rebate],0) as [Q4 API Whse Rebate],
isnull(r.[Q4 API Generic Rebate%],0) as [Q4 API Generic Rebate%],
isnull(r.[Total API Whse Rebate 2010],0) as [Total API Whse Rebate 2010],
isnull(r.[Leader AAP 2010Q1],0) as [Leader AAP 2010Q1],
isnull(r.[Leader AAP 2010Q2],0) as [Leader AAP 2010Q2],
isnull(r.[Leader AAP 2010Q3],0) as [Leader AAP 2010Q3],
isnull(r.[Leader AAP 2010Q4],0) as [Leader AAP 2010Q4],
isnull(r.[Total Leader AAP 2010],0) as [Total Leader AAP 2010],
isnull(r.[2/10 Source Sales],0) as [2/10 Source Sales],
isnull(r.[2/10 AAP Gen Rebate],0) as [2/10 AAP Gen Rebate],
isnull(r.[2/10 Avg%],0) as [2/10 Avg%],
isnull(r.[2/10 HRTA%],0) as [2/10 HRTA%],
isnull(r.[3/10 Source Sales],0) as [3/10 Source Sales],
isnull(r.[3/10 AAP Gen Rebate],0) as [3/10 AAP Gen Rebate],
isnull(r.[3/10 Avg%],0) as [3/10 Avg%],
isnull(r.[3/10 HRTA%],0) as [3/10 HRTA%],
isnull(r.[4/10 Source Sales],0) as [4/10 Source Sales],
isnull(r.[4/10 AAP Gen Rebate],0) as [4/10 AAP Gen Rebate],
isnull(r.[4/10 Avg%],0) as [4/10 Avg%],
isnull(r.[4/10 HRTA%],0) as [4/10 HRTA%],
isnull(r.[5/10 Source Sales],0) as [5/10 Source Sales],
isnull(r.[5/10 AAP Gen Rebate],0) as [5/10 AAP Gen Rebate],
isnull(r.[5/10 Avg%],0) as [5/10 Avg%],
isnull(r.[5/10 HRTA%],0) as [5/10 HRTA%],
isnull(r.[6/10 Source Sales],0) as [6/10 Source Sales],
isnull(r.[6/10 AAP Gen Rebate],0) as [6/10 AAP Gen Rebate],
isnull(r.[6/10 Avg%],0) as [6/10 Avg%],
isnull(r.[6/10 HRTA%],0) as [6/10 HRTA%],
isnull(r.[7/10 Source Sales],0) as [7/10 Source Sales],
isnull(r.[7/10 AAP Gen Rebate],0) as [7/10 AAP Gen Rebate],
isnull(r.[7/10 Avg%],0) as [7/10 Avg%],
isnull(r.[7/10 HRTA%],0) as [7/10 HRTA%],
isnull(r.[8/10 Source Sales],0) as [8/10 Source Sales],
isnull(r.[8/10 AAP Gen Rebate],0) as [8/10 AAP Gen Rebate],
isnull(r.[8/10 Avg%],0) as [8/10 Avg%],
isnull(r.[8/10 HRTA%],0) as [8/10 HRTA%],
isnull(r.[9/10 Source Sales],0) as [9/10 Source Sales],
isnull(r.[9/10 AAP Gen Rebate],0) as [9/10 AAP Gen Rebate],
isnull(r.[9/10 Avg%],0) as [9/10 Avg%],
isnull(r.[9/10 HRTA%],0) as [9/10 HRTA%],
isnull(r.[10/10 Source Sales],0) as [10/10 Source Sales],
isnull(r.[10/10 AAP Gen Rebate],0) as [10/10 AAP Gen Rebate],
isnull(r.[10/10 Avg%],0) as [10/10 Avg%],
isnull(r.[10/10 HRTA%],0) as [10/10 HRTA%], --changed 10/10 uses spreadsheet value not calculated note no x100 after fixed source table
isnull(r.[11/10 Source Sales],0) as [11/10 Source Sales],
isnull(r.[11/10 AAP Gen Rebate],0) as [11/10 AAP Gen Rebate],
isnull(r.[11/10 Avg%],0) as [11/10 Avg%],
isnull(r.[11/10 HRTA%],0) as [11/10 HRTA%],
isnull(r.[12/10 Source Sales],0) as [12/10 Source Sales],
isnull(r.[12/10 AAP Gen Rebate],0) as [12/10 AAP Gen Rebate],
isnull(r.[12/10 Avg%],0) as [12/10 Avg%],
isnull(r.[12/10 HRTA%],0) as [12/10 HRTA%],
isnull(r.[Total CH AAP Gen Rebate 2010],0) as [Total CH AAP Gen Rebate 2010],
isnull(r.[Total YTD All Rebates],0) as [Total YTD All Rebates]


into reports..report_RCRebates_Q4APIWH

from reports..report_RCRebates_Q4APIWH_pivotedData r
left join pharmacymaster..v_PM_AllWithAffiliates p on r.pmid=p.pmid

where p.pmid is not null
and isnull([total ytd all rebates],0)<>0
and ((p.Affiliate is null or p.Affiliate='')
or (p.Affiliate not in ('PIPCO') and p.Affiliate not like 'KEYSTONE%' and p.Affiliate not like 'LEGEND%'))
end
GO
