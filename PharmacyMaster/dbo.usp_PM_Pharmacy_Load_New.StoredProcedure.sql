USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_PM_Pharmacy_Load_New]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_PM_Pharmacy_Load_New]

AS

SET NOCOUNT ON;

BEGIN


--Update any exists rows
UPDATE dbo.PM_Pharmacy_CRM
SET	PMParentID = ISNULL(s.PMParentID, p.PMParentID)
	, AAPAccountNo = ISNULL(s.AAPAccountNo, p.AAPAccountNo)
	, AAPEffectiveDate = ISNULL(s.AAPEffectiveDate, p.AAPEffectiveDate)
	, AAPParentNo = ISNULL(s.AAPParentNo, p.AAPParentNo)
	, AAPPreviousGroup = ISNULL(s.AAPPreviousGroup, p.AAPPreviousGroup)
	, AAPQuitDate = ISNULL(s.AAPQuitDate, p.AAPQuitDate)
	, AAPStatus = ISNULL(s.AAPStatus, p.AAPStatus)
	, AccountDescription = ISNULL(s.AccountDescription, p.AccountDescription)
	, AccountName = ISNULL(s.AccountName, p.AccountName)
	, AllowDupDEA = ISNULL(s.AllowDupDEA, p.AllowDupDEA)
	, APIAccountNo = ISNULL(s.APIAccountNo, p.APIAccountNo)
	, APIDEA = ISNULL(s.APIDEA, p.APIDEA)
	, APIMemberNo = ISNULL(s.APIMemberNo, p.APIMemberNo)
	, APIPMID = ISNULL(s.APIPMID, p.APIPMID)
	, APIStatus = ISNULL(s.APIStatus, p.APIStatus)
	, AvgWholesaleVolume = ISNULL(s.AvgWholesaleVolume, p.AvgWholesaleVolume)
	, BusinessClass = ISNULL(s.BusinessClass, p.BusinessClass)
	, CAHStatus = ISNULL(s.CAHStatus, p.CAHStatus)
	, CardinalDC = ISNULL(s.CardinalDC, p.CardinalDC)
	, CategoryID = ISNULL(s.CategoryID, p.CategoryID)
	, CompetitiveAcct = ISNULL(s.CompetitiveAcct, p.CompetitiveAcct)
	, ComputerSoftware = ISNULL(s.ComputerSoftware, p.ComputerSoftware)
	, ContractDate = ISNULL(s.ContractDate, p.ContractDate)
	, CorporateName = ISNULL(s.CorporateName, p.CorporateName)
	, CustPayTermsAPI = ISNULL(s.CustPayTermsAPI, p.CustPayTermsAPI)
	, DateOpened = ISNULL(s.DateOpened, p.DateOpened)
	, DBA = ISNULL(s.DBA, p.DBA)
	, DEA = ISNULL(s.DEA, p.DEA)
	, DEAEXP = ISNULL(s.DEAEXP, p.DEAEXP)
	, Email = ISNULL(s.Email, p.Email)
	, EmergencyPhone = ISNULL(s.EmergencyPhone, p.EmergencyPhone)
	, EstMonthlyVol = ISNULL(s.EstMonthlyVol, p.EstMonthlyVol)
	, FedID = ISNULL(s.FedID, p.FedID)
	, GroupNo = ISNULL(s.GroupNo, p.GroupNo)
	, HolidayHours = ISNULL(s.HolidayHours, p.HolidayHours)
	, Hours = ISNULL(s.Hours, p.Hours)
	, IsHighVolume = ISNULL(s.IsHighVolume, p.IsHighVolume)
	, StoreHours_HolidayAM = ISNULL(s.StoreHours_HolidayAM, p.StoreHours_HolidayAM)
	, StoreHours_HolidayPM = ISNULL(s.StoreHours_HolidayPM, p.StoreHours_HolidayPM)
	, StoreHours_MondayFridayAM = ISNULL(s.StoreHours_MondayFridayAM, p.StoreHours_MondayFridayAM)
	, StoreHours_MondayFridayPM = ISNULL(s.StoreHours_MondayFridayPM, p.StoreHours_MondayFridayPM)
	, StoreHours_SaturdayAM = ISNULL(s.StoreHours_SaturdayAM, p.StoreHours_SaturdayAM)
	, StoreHours_SaturdayPM = ISNULL(s.StoreHours_SaturdayPM, p.StoreHours_SaturdayPM)
	, StoreHours_SundayAM = ISNULL(s.StoreHours_SundayAM, p.StoreHours_SundayAM)
	, StoreHours_SundayPM = ISNULL(s.StoreHours_SundayPM, p.StoreHours_SundayPM)
	, IsStartUpStore = ISNULL(s.IsStartUpStore, p.IsStartUpStore)
	, NCPDP = ISNULL(s.NCPDP, p.NCPDP)
	, NPI = ISNULL(s.NPI, p.NPI)
	, NumReactivated = ISNULL(s.NumReactivated, p.NumReactivated)
	, OrigStartDate = ISNULL(s.OrigStartDate, p.OrigStartDate)
	, OwnerName = ISNULL(s.OwnerName, p.OwnerName)
	, Payee_id = ISNULL(s.Payee_id, p.Payee_id)
	, PrimaryCAAccountNo = ISNULL(s.PrimaryCAAccountNo, p.PrimaryCAAccountNo)
	, PrimaryWholesaler = ISNULL(s.PrimaryWholesaler, p.PrimaryWholesaler)
	, QPS = ISNULL(s.QPS, p.QPS)
	, Rank = ISNULL(s.Rank, p.Rank)
	, Resigned = ISNULL(s.Resigned, p.Resigned)
	, Source = ISNULL(s.Source, p.Source)
	, Status = ISNULL(s.Status, p.Status)
	, Territory = ISNULL(s.Territory, p.Territory)
	, UDAccountNo = ISNULL(s.UDAccountNo, p.UDAccountNo)
	, UDNonPharmacy = ISNULL(s.UDNonPharmacy, p.UDNonPharmacy)
	, UDParentNo = ISNULL(s.UDParentNo, p.UDParentNo)
	, UDQuitDate = ISNULL(s.UDQuitDate, p.UDQuitDate)
	, UDStatus = ISNULL(s.UDStatus, p.UDStatus)
	, Website = ISNULL(s.Website, p.Website)
	, Wholesaler = ISNULL(s.Wholesaler, p.Wholesaler)
	, WholesalerAccountNo = ISNULL(s.WholesalerAccountNo, p.WholesalerAccountNo)
	, WhyResigned = ISNULL(s.WhyResigned, p.WhyResigned)
	, IsBuyingGroup = ISNULL(s.IsBuyingGroup, p.IsBuyingGroup)
	, IsPos = ISNULL(s.IsPos, p.IsPos)
	, IsPva = ISNULL(s.IsPva, p.IsPva)
	, FeePaid = ISNULL(s.FeePaid, p.FeePaid)
	, IsManagedCare = ISNULL(s.IsManagedCare, p.IsManagedCare)
	, IsWarehouse = ISNULL(s.IsWarehouse, p.IsWarehouse)
	, IsNPP = ISNULL(s.IsNPP, p.IsNPP)
	, ACHEmail = ISNULL(s.ACHEmail, p.ACHEmail)
	, Created = ISNULL(s.Created, p.Created)
	, Modified = ISNULL(s.Modified, p.Modified)
	, RowVersion = ISNULL(s.RowVersion, p.RowVersion)
	, MembershipType = ISNULL(s.MembershipType, p.MembershipType)
	, OrganizationType = ISNULL(s.OrganizationType, p.OrganizationType)
	, AuthorizedVoter = ISNULL(s.AuthorizedVoter, p.AuthorizedVoter)
	, MembershipOwner = ISNULL(s.MembershipOwner, p.MembershipOwner)
	, WHSNUM = ISNULL(s.WHSNUM, p.WHSNUM)
	, PlansExcluded = ISNULL(s.PlansExcluded, p.PlansExcluded)
	, IsClaimData = ISNULL(s.IsClaimData, p.IsClaimData)
	, IsUPCData = ISNULL(s.IsUPCData, p.IsUPCData)
	, MedicarePartBNo = ISNULL(s.MedicarePartBNo, p.MedicarePartBNo)
	, DoNotFax = ISNULL(s.DoNotFax, p.DoNotFax)
	, CommunicationPreference = ISNULL(s.CommunicationPreference, p.CommunicationPreference)
	, APIPaymentMode = ISNULL(s.APIPaymentMode, p.APIPaymentMode)
	, AAPPaymentMode = ISNULL(s.AAPPaymentMode, p.AAPPaymentMode)
	, NCPA = ISNULL(s.NCPA, p.NCPA)
	, OptOutNCPA = ISNULL(s.OptOutNCPA, p.OptOutNCPA)
	, ReasonNotEligibleNCPA = ISNULL(s.ReasonNotEligibleNCPA, p.ReasonNotEligibleNCPA)
FROM dbo.PM_Pharmacy_CRM AS p
LEFT OUTER JOIN Staging.PM_Pharmacy AS s ON p.PMID = s.PMID

SET IDENTITY_INSERT dbo.PM_Pharmacy_CRM ON;

--Insert any new PMID's that do not currently exists
INSERT INTO dbo.PM_Pharmacy_CRM(PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription, AccountName
							, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus, CardinalDC, CategoryID
							, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email, EmergencyPhone
							, EstMonthlyVol, FedID, GroupNo, Hours, IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM, StoreHours_MondayFridayAM, StoreHours_MondayFridayPM
							, StoreHours_SaturdayAM, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated, OrigStartDate
							, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler, QPS, Rank, Resigned, Source, Status, Territory, UDAccountNo, UDNonPharmacy, UDParentNo
							, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, IsPva, FeePaid, IsManagedCare, IsWarehouse, IsNPP
							, ACHEmail, Created, Modified, RowVersion, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM, PlansExcluded, IsClaimData, IsUPCData
							, MedicarePartBNo, DoNotFax, CommunicationPreference, APIPaymentMode, AAPPaymentMode, NCPA, OptOutNCPA, ReasonNotEligibleNCPA
							)
SELECT s.PMID, s.PMParentID, s.AAPAccountNo, s.AAPEffectiveDate, s.AAPParentNo, s.AAPPreviousGroup, s.AAPQuitDate, s.AAPStatus, s.AccountDescription, s.AccountName
, s.AllowDupDEA, s.APIAccountNo, s.APIDEA, s.APIMemberNo, s.APIPMID, s.APIStatus, s.AvgWholesaleVolume, s.BusinessClass, s.CAHStatus, s.CardinalDC, s.CategoryID
, s.CompetitiveAcct, s.ComputerSoftware, s.ContractDate, s.CorporateName, s.CustPayTermsAPI, s.DateOpened, s.DBA, s.DEA, s.DEAEXP, s.Email, s.EmergencyPhone
, s.EstMonthlyVol, s.FedID, s.GroupNo, s.Hours, s.IsHighVolume, s.StoreHours_HolidayAM, s.StoreHours_HolidayPM, s.StoreHours_MondayFridayAM, s.StoreHours_MondayFridayPM
, s.StoreHours_SaturdayAM, s.StoreHours_SaturdayPM, s.StoreHours_SundayAM, s.StoreHours_SundayPM, s.IsStartUpStore, s.NCPDP, s.NPI, s.NumReactivated, s.OrigStartDate
, s.OwnerName, s.Payee_id, s.PrimaryCAAccountNo, s.PrimaryWholesaler, s.QPS, s.Rank, s.Resigned, s.Source, s.Status, s.Territory, s.UDAccountNo, s.UDNonPharmacy, s.UDParentNo
, s.UDQuitDate, s.UDStatus, s.Website, s.Wholesaler, s.WholesalerAccountNo, s.WhyResigned, s.IsBuyingGroup, s.IsPos, s.IsPva, s.FeePaid, s.IsManagedCare, s.IsWarehouse, s.IsNPP
, s.ACHEmail, s.Created, s.Modified, s.RowVersion, s.MembershipType, s.OrganizationType, s.AuthorizedVoter, s.MembershipOwner, s.WHSNUM, s.PlansExcluded, s.IsClaimData, s.IsUPCData
, s.MedicarePartBNo, s.DoNotFax, s.CommunicationPreference, s.APIPaymentMode, s.AAPPaymentMode, s.NCPA, s.OptOutNCPA, s.ReasonNotEligibleNCPA
FROM(SELECT pmid
	, MAX(versionnumber) AS versionnumber
	FROM PharmacyMaster.[Staging].[vw_PM_Pharmacy]
	GROUP BY pmid
	) AS dt
INNER JOIN PharmacyMaster.[Staging].[vw_PM_Pharmacy] AS s ON dt.pmid = s.pmid
												AND dt.versionnumber = s.versionnumber
WHERE NOT EXISTS(SELECT 1
					FROM dbo.PM_Pharmacy_CRM AS p
					WHERE dt.PMID = p.PMID
				)

SET IDENTITY_INSERT dbo.PM_Pharmacy_CRM OFF;

END
GO
