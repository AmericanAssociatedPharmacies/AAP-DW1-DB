USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_Anything_to_PMID]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_Anything_to_PMID]
as
select PMID, NCPDP as Anything, 'NCPDP' as type 
from v_pm_AllWithAffiliates
where NCPDP is not null
union
select PMID,CHAcct as Anything, 'CHAcct' as type
from v_CHAccountPMID
where CHAcct is not null
union
select PMID, DEA as Anything, 'DEA' as type 
from v_pm_AllWithAffiliates
where DEA is not null
union
select PMID, AAPAccountNo as Anything, 'AAPAccountNo' as type 
from v_pm_AllWithAffiliates
where AAPAccountNo is not null
union
select PMID, APIAccountNo as Anything, 'APIAccountNo' as type 
from v_pm_AllWithAffiliates
where APIAccountNo is not null
union
select PMID, UDAccountNo as Anything, 'UDAccountNo' as type 
from v_pm_AllWithAffiliates
where UDAccountNo is not null

--grant select on v_Anything_to_PMID to EXCELMACROFDB
GO
