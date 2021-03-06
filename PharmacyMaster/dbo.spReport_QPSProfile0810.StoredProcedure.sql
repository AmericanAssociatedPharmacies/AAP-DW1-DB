USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spReport_QPSProfile0810]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spReport_QPSProfile0810]
as
-- QPS Pharmacy Profile Report
-- 8/16/10 BG
-- warning: hardcoded dates
select v.PMID, 
v.aapaccountno as [AAP#],
v.apiaccountno as [API#],
v.accountname as Name,
--v.addr1 as address,
v.City,v.state as St,v.territory as TM,
v.aapeffectivedate as [Effective],
v.APIStatus,
v.Chaincode as Chain,
--v.IsManagedCare, --works?
case when mc.pmid is null then 'N' else 'Y' end as [M.Care],
--v.QPS,
isnull(dtCHQ2.combnetsales,0) as CHSales_Q2,
isnull(dtCH0610.combnetsales,0) as CHSales_0610,
isnull(dtAPIQ2.API_Total,0) as API_Q2,
isnull(dtAPI0610.API_Total,0) as API_0610

from  v_PM_AllWithAffiliates  v
left join
(
select pmid,sum(combnetsales) as combnetsales
from CH_ALLPVA_SALES
where date >='4/1/2010' and date <= '6/1/2010'
group by pmid
) dtCHQ2 on v.PMID=dtCHQ2.PMID
left join
(
select pmid,sum(combnetsales) as combnetsales
from CH_ALLPVA_SALES
where date = '6/1/2010'
group by pmid
) dtCH0610 on v.PMID=dtCH0610.PMID
left join
(
select pmid,sum(API_Total) as API_Total
from api..v_API_LineItem_ByPMIDbyMonth
where date >='4/1/2010' and date <= '6/1/2010'
group by pmid
) dtAPIQ2 on v.PMID=dtAPIQ2.PMID
left join
(
select pmid,sum(API_Total) as API_Total
from api..v_API_LineItem_ByPMIDbyMonth
where date = '6/1/2010'
group by pmid
) dtAPI0610 on v.PMID=dtAPI0610.PMID

left join pharmacymaster..pm_managedcare mc on v.pmid=mc.pmid and mc.mcquitdate is null and mc.chaincode is not null

where v.aapquitdate is null
and v.qps = 'qps'
and (v.apistatus = 'ACTIVE' or isnull(dtCHQ2.combnetsales,0) <> 0 or isnull(dtAPIQ2.API_Total,0)<>0)

order by pmid
GO
