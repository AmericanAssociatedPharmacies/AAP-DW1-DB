USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_CredentiallingPrepopulate]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_CredentiallingPrepopulate]
AS
SELECT
dbo.PM_Pharmacy.PMID
,dbo.PM_Pharmacy.Accountname 
,dbo.PM_Pharmacy.CorporateName 
,dbo.PM_Pharmacy.DateOpened 
,dbo.PM_Pharmacy.DBA 
,dbo.PM_Pharmacy.DEA 
,dbo.PM_Pharmacy.DEAEXP 
,dbo.PM_Pharmacy.Email AS PharmacyEmail 
,dbo.PM_Pharmacy.EmergencyPhone 
,dbo.PM_Pharmacy.FedID 
,StoreHours_MondayFridayAM + ' AM' AS StoreHours_MondayFridayAM
,StoreHours_MondayFridayPM + ' PM' AS StoreHours_MondayFridayPM 
,StoreHours_SaturdayAM + ' AM' AS StoreHours_SaturdayAM 
,StoreHours_SaturdayPM + ' PM' AS StoreHours_SaturdayPM 
,StoreHours_SundayAM+ ' AM' AS StoreHours_SundayAM 
,StoreHours_SundayPM+ ' PM' AS StoreHours_SundayPM
,dbo.PM_Pharmacy.NCPDP 
,dbo.PM_Pharmacy.NPI 
,dbo.PM_Pharmacy.Website 
,dbo.PM_Pharmacy.MembershipType 
,dbo.PM_Pharmacy.OrganizationType 
,dbo.PM_Pharmacy.MembershipOwner 
,dbo.PM_Cred.StateLicNo 
,dbo.PM_Cred.StateMedicaidNo 
,dbo.PM_Cred.StateLicExpDate 
,dbo.PM_Cred.StateLicNo2 
,dbo.PM_Cred.StateMedicaidNo2 
,dbo.PM_Cred.StateLicExpDate2 
,dbo.PM_Cred.GenLiabCarrier 
,dbo.PM_Cred.GenLiabPolicyNumber 
,dbo.PM_Cred.GenLiabilityLimit1 
,dbo.PM_Cred.GenLiabilityLimit2 
,dbo.PM_Cred.GenInsExpDate 
,dbo.PM_Cred.DeliveryService 
,dbo.PM_Cred.EmergencyServices 
,dbo.PM_Cred.AnsweringServiceOrMachine 
,dbo.PM_Cred.AlternativeLanguages 
,dbo.PM_Cred.SpecialtyServices 
,dbo.PM_Pharmacy.OwnerName
,am1.Phone 
,am1.Fax
,am1.Email 
,am1.Address 
,am1.Address2 
,am1.County 
,am1.City 
,am1.State 
,am1.Zip 
,am1.ContactFullName 
--,am2.Phone as MailPhone
--,am2.Email as MailEmail
,am2.Address as MailAddr1
,am2.Address2 as MailAddr2
--,am2.County as MailCounty
,am2.City as MailCity
,am2.State as MailState
,am2.Zip as MailZip
--,am2.ContactFullName as MailContactFullName 
,dbo.PM_Pharmacists.PharPrime 
,dbo.PM_Pharmacists.PharFullName 
,dbo.PM_Pharmacists.PharTitle 
,dbo.PM_Pharmacists.PharState 
,dbo.PM_Pharmacists.PharLicNo 
,dbo.PM_Pharmacists.PharExpDate
from
PM_Pharmacy
left join PM_Cred on PM_Cred.PMID=PM_Pharmacy.PMID
left join PM_AddressMaster am1 on (am1.PMID=PM_Pharmacy.PMID and am1.Address_Type_Id = 1)
left join PM_AddressMaster am2 on (am2.PMID=PM_Pharmacy.PMID and am2.Address_Type_Id = 2)
left join PM_Pharmacists on PM_Pharmacists.PMID=PM_Pharmacy.PMID

GO
