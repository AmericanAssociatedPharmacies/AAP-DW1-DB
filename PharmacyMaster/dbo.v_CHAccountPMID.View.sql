USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_CHAccountPMID]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select count(1) from v_CHAccountPMID

CREATE view [dbo].[v_CHAccountPMID]
as
--un-pivot CH account numbers 7/12 BG
select PMID,CHAccount as CHAcct,'Pharmacymaster.dbo.CHACCT_PMID' as Type
from Pharmacymaster.dbo.CHACCT_PMID
where CHAccount is not null
union
select PMID,CHAccountNoPrimary as CHAcct,'CHAccountNoPrimary' as Type
from PM_CHAccounts_ADJ
where CHAccountNoPrimary is not null
union
select PMID,CHAccountNo2 as CHAcct,'CHAccountNo2' as Type
from PM_CHAccounts_ADJ
where CHAccountNo2 is not null
union
select PMID,CHAccountNo3 as CHAcct,'CHAccountNo3' as Type
from PM_CHAccounts_ADJ
where CHAccountNo3 is not null
union
select PMID,POSAcct as CHAcct,'POSAcct' as Type
from PM_CHAccounts_ADJ
where POSAcct is not null
union
select PMID,ScanTossAcct as CHAcct,'ScanTossAcct' as Type
from PM_CHAccounts_ADJ
where ScanTossAcct is not null
union
select PMID,CSOSAcct as CHAcct,'CSOSAcct' as Type
from PM_CHAccounts_ADJ
where CSOSAcct is not null
union
select PMID,SecondPrimaryNumber as CHAcct,'SecondPrimaryNumber' as Type
from PM_CHAccounts_ADJ
where SecondPrimaryNumber is not null
union
select PMID,Second2nd as CHAcct,'Second2nd' as Type
from PM_CHAccounts_ADJ
where Second2nd is not null
union
select PMID,Second3rd as CHAcct,'Second3rd' as Type
from PM_CHAccounts_ADJ
where Second3rd is not null
union
select PMID,SecondPOS as CHAcct,'SecondPOS' as Type
from PM_CHAccounts_ADJ
where SecondPOS is not null
union
select PMID,SecondCSOS as CHAcct,'SecondCSOS' as Type
from PM_CHAccounts_ADJ
where SecondCSOS is not null
union
select PMID,SecondCST as CHAcct,'SecondCST' as Type
from PM_CHAccounts_ADJ
where SecondCST is not null
union
select PMID,ThirdPrimaryNumber as CHAcct,'ThirdPrimaryNumber' as Type
from PM_CHAccounts_ADJ
where ThirdPrimaryNumber is not null
union
select PMID,Third2nd as CHAcct,'Third2nd' as Type
from PM_CHAccounts_ADJ
where Third2nd is not null
union
select PMID,ThirdPOS as CHAcct,'ThirdPOS' as Type
from PM_CHAccounts_ADJ
where ThirdPOS is not null
union
select PMID,ThirdCSOS as CHAcct,'ThirdCSOS' as Type
from PM_CHAccounts_ADJ
where ThirdCSOS is not null
union
select PMID,ThirdCST as CHAcct,'ThirdCST' as Type
from PM_CHAccounts_ADJ
where ThirdCST is not null
--order by CHAcct

GO
