USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_Pharmacy]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_Pharmacy]
AS

SELECT 
p.PMID,PMParentID,AAPAccountNo,AAPEffectiveDate,AAPParentNo,AAPPreviousGroup,AAPQuitDate,AAPStatus,AccountDescription,AccountName,
a.address as Addr1,a.address2 as Addr2,APIAccountNo,APIMemberNo,APIStatus,AvgWholesaleVolume,BusinessClass,CAHStatus,CardinalDC,m.ChainCode,
a.City,CompetitiveAcct,ComputerSoftware,a.ContactFullName,ContractDate,CorporateName,CustPayTermsAPI,DateOpened,DBA,
DEA,DEAEXP,Email,EmergencyPhone,a.Fax,FedID,HolidayHours,Hours,IsStartUpStore,m.MCEffectiveDate,m.MCQuitDate,NCPDP,
NPI,NumReactivated,OrigStartDate,OwnerName,Payee_id,a.Phone,PrimaryCAAccountNo,QPS,Rank,Resigned,Source,a.State,c.StateLicExpDate,c.StateLicNo,
Status,Territory,UDAccountNo,UDNonPharmacy,UDParentNo,UDQuitDate,UDStatus,Website,Wholesaler,WholesalerAccountNo,WhyResigned,a.Zip
from PM_Pharmacy p
join 
(
select pmid,address,address2,ContactFullName,City,State,Zip,Phone,Fax from pm_addressmaster where address_type_id = 1
) a
on p.pmid = a.pmid
left outer join 
(
select chaincode,mceffectivedate,mcquitdate,pmid from pm_managedcare
) m
on p.pmid = m.pmid
left outer join
(
select StateLicExpDate,StateLicNo,pmid from pm_cred
)c
on p.pmid = c.pmid

 
GO
