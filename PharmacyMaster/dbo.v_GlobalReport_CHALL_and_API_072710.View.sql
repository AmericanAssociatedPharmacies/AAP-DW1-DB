USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_GlobalReport_CHALL_and_API_072710]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_GlobalReport_CHALL_and_API_072710]
as
--7/20 replaced line amount view with extended sales view
--all PMIDs + challpva joined to api
--union part 1 sales for those in pm part 2 those not in pm
select p_pmid,ch.pmid as pmid,ch.[date] as [date],
[Gen Src],[Gen Exc],[Gen Total],[CH Brx],[CH Oth],[UD Adm],[CH Total],
a.pmid as a_pmid,
a.date as a_date,
a.API_BR,a.API_GEN,a.API_OTC,
a.API_BR+a.API_GEN+a.API_OTC as API_Total

from v_GlobalReport_CHall ch
--left join api..v_API_ByMonth_LineAmount2010 a 
left join api..v_API_ByMonth_ExtSales2010 a
on ch.p_pmid=a.pmid and ch.date=a.date
--was on ch.pmid 07/20/10 13:02:10

union
--APIs without PMIDs - totals for balancing

select -1 as p_pmid,
-1 as pmid,
a.[date] as [date],
[Gen Src],[Gen Exc],[Gen Total],[CH Brx],[CH Oth],[UD Adm], [CH Total],
a.pmid as a_pmid,
a.date as a_date,
a.API_BR,a.API_GEN,a.API_OTC,
a.API_BR+a.API_GEN+a.API_OTC as API_Total
from
--api..v_API_ByMonth_LineAmount2010 a
api..v_API_ByMonth_ExtSales2010 a
left join v_GlobalReport_CHall ch on a.pmid=ch.p_pmid and a.date=ch.date
where p_pmid is null	
GO
