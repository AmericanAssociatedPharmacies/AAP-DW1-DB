USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_CHAccounts_Adj_union]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view
[dbo].[v_PM_CHAccounts_Adj_union]
as
select PMID, CHAccountNoPrimary as CHAcct from PM_CHAccounts_ADJ where CHAccountNoPrimary is not null
union
select PMID, CHAccountNo2 as CHAcct from PM_CHAccounts_ADJ where CHAccountNo2 is not null
union
select PMID, CHAccountNo3 as CHAcct from PM_CHAccounts_ADJ where CHAccountNo3 is not null
union
select PMID, ScanTossAcct as CHAcct from PM_CHAccounts_ADJ where ScanTossAcct is not null
union
select PMID, POSAcct as CHAcct from PM_CHAccounts_ADJ where POSAcct is not null
union
select PMID, CSOSAcct as CHAcct from PM_CHAccounts_ADJ where CSOSAcct is not null
union
select PMID, SecondPrimaryNumber as CHAcct from PM_CHAccounts_ADJ where SecondPrimaryNumber is not null
union
select PMID, Second2nd as CHAcct from PM_CHAccounts_ADJ where Second2nd is not null
union
select PMID, Second3rd as CHAcct from PM_CHAccounts_ADJ where Second3rd is not null
union
select PMID, SecondPOS as CHAcct from PM_CHAccounts_ADJ where SecondPOS is not null
union
select PMID, SecondCSOS as CHAcct from PM_CHAccounts_ADJ where SecondCSOS is not null
union
select PMID, SecondCST as CHAcct from PM_CHAccounts_ADJ where SecondCST is not null
union
select PMID, ThirdPrimaryNumber as CHAcct from PM_CHAccounts_ADJ where ThirdPrimaryNumber is not null
union
select PMID, Third2nd as CHAcct from PM_CHAccounts_ADJ where Third2nd is not null
union
select PMID, ThirdPOS as CHAcct from PM_CHAccounts_ADJ where ThirdPOS is not null
union
select PMID, ThirdCSOS as CHAcct from PM_CHAccounts_ADJ where ThirdCSOS is not null
union
select PMID, ThirdCST as CHAcct from PM_CHAccounts_ADJ where ThirdCST is not null
GO
