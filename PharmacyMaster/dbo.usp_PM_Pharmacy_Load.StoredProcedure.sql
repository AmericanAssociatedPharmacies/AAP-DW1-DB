USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_PM_Pharmacy_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_PM_Pharmacy_Load]

AS

SET NOCOUNT ON;

BEGIN

	--Archive current data for historical purposes. The "Archive.PM_Pharmacy" is used for loading purposes only and does not keep history.
	SET IDENTITY_INSERT [dbo].[PM_Pharmacy_Archive] ON

	INSERT INTO [dbo].[PM_Pharmacy_Archive](PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription
	, AccountName, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus, CardinalDC
	, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email
	, EmergencyPhone, EstMonthlyVol, FedID, GroupNo, Hours, IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM, StoreHours_MondayFridayAM
	, StoreHours_MondayFridayPM, StoreHours_SaturdayAM, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated
	, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler, QPS, Rank, Resigned, Source, Status, Territory, UDAccountNo, UDNonPharmacy, UDParentNo
	, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created
	, Modified, RowVersion, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
	, CommunicationPreference, APIPaymentMode, AAPPaymentMode, NCPA, OptOutNCPA, ReasonNotEligibleNCPA)
	SELECT PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription
	, AccountName, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus, CardinalDC
	, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email
	, EmergencyPhone, EstMonthlyVol, FedID, GroupNo, Hours, IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM, StoreHours_MondayFridayAM
	, StoreHours_MondayFridayPM, StoreHours_SaturdayAM, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated
	, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler, QPS, Rank, Resigned, Source, Status, Territory, UDAccountNo, UDNonPharmacy, UDParentNo
	, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created
	, Modified, RowVersion, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
	, CommunicationPreference, APIPaymentMode, AAPPaymentMode, NCPA, OptOutNCPA, ReasonNotEligibleNCPA
	FROM dbo.PM_Pharmacy

	SET IDENTITY_INSERT [dbo].[PM_Pharmacy_Archive] OFF

	UPDATE dbo.PM_Pharmacy
	SET PMParentID = s.PMParentID, AAPAccountNo = s.AAPAccountNo, AAPEffectiveDate = s.AAPEffectiveDate
		, AAPParentNo = s.AAPParentNo, AAPPreviousGroup = x.AAPPreviousGroup, AAPQuitDate = s.AAPQuitDate
		, AAPStatus = s.AAPStatus, AccountDescription = s.AccountDescription, AccountName = s.AccountName
		, AllowDupDEA = s.AllowDupDEA, APIAccountNo = s.APIAccountNo, APIDEA = s.APIDEA
		, APIMemberNo = s.APIMemberNo, APIPMID = s.APIPMID, APIStatus = s.APIStatus
		, AvgWholesaleVolume = s.AvgWholesaleVolume, BusinessClass = s.BusinessClass, CAHStatus = s.CAHStatus
		, CardinalDC = s.CardinalDC, CategoryID = s.CategoryID, CompetitiveAcct = s.CompetitiveAcct
		, ComputerSoftware = s.ComputerSoftware, ContractDate = s.ContractDate, CorporateName = s.CorporateName
		, CustPayTermsAPI = s.CustPayTermsAPI, DateOpened = s.DateOpened, DBA = s.DBA
		, DEA = s.DEA, DEAEXP = s.DEAEXP, Email = s.Email
		, EmergencyPhone = s.EmergencyPhone, EstMonthlyVol = s.EstMonthlyVol, FedID = s.FedID
		, GroupNo = s.GroupNo, HolidayHours = s.HolidayHours, Hours = s.Hours
		, IsHighVolume = s.IsHighVolume, StoreHours_HolidayAM = s.StoreHours_HolidayAM, StoreHours_HolidayPM = s.StoreHours_HolidayPM
		, StoreHours_MondayFridayAM = s.StoreHours_MondayFridayAM, StoreHours_MondayFridayPM = s.StoreHours_MondayFridayPM, StoreHours_SaturdayAM = s.StoreHours_SaturdayAM
		, StoreHours_SaturdayPM = s.StoreHours_SaturdayPM, StoreHours_SundayAM = s.StoreHours_SundayAM, StoreHours_SundayPM = s.StoreHours_SundayPM
		, IsStartUpStore = s.IsStartUpStore, NCPDP = s.NCPDP, NPI = s.NPI
		, NumReactivated = s.NumReactivated, OrigStartDate = s.OrigStartDate, OwnerName = s.OwnerName
		, Payee_id = x.Payee_id, PrimaryCAAccountNo = x.PrimaryCAAccountNo, PrimaryWholesaler = x.PrimaryWholesaler
		, QPS = s.QPS, [Rank] = x.[Rank], Source = s.Source, Status = s.Status, Territory = s.Territory
		, UDAccountNo = x.UDAccountNo, UDNonPharmacy = x.UDNonPharmacy, UDParentNo = x.UDParentNo
		, UDQuitDate = x.UDQuitDate, UDStatus = x.UDStatus, Website = s.Website
		, Wholesaler = x.Wholesaler, WholesalerAccountNo = x.WholesalerAccountNo, WhyResigned = s.WhyResigned
		, IsBuyingGroup = s.IsBuyingGroup, IsPos = s.IsPos, IsPva = s.IsPva
		, FeePaid = s.FeePaid, IsManagedCare = s.IsManagedCare, IsWarehouse = s.IsWarehouse
		, IsNPP = x.IsNPP, ACHEmail = x.ACHEmail, Created = x.Created
		, Modified = s.Modified, [RowVersion] = s.[RowVersion], MembershipType = s.MembershipType
		, OrganizationType = s.OrganizationType, AuthorizedVoter = s.AuthorizedVoter, MembershipOwner = s.MembershipOwner
		, WHSNUM = s.WHSNUM, PlansExcluded = s.PlansExcluded, IsClaimData = x.IsClaimData
		, IsUPCData = x.IsUPCData, MedicarePartBNo = s.MedicarePartBNo, DoNotFax = s.DoNotFax
		, CommunicationPreference = x.CommunicationPreference, APIPaymentMode = x.APIPaymentMode, AAPPaymentMode = x.AAPPaymentMode
		, NCPA = s.NCPA, OptOutNCPA = s.OptOutNCPA
	FROM dbo.PM_Pharmacy AS x
	INNER JOIN [Staging].[PM_Pharmacy_DynamicsETL] AS s ON x.PMID = s.PMID



	SET IDENTITY_INSERT dbo.PM_Pharmacy ON

	INSERT INTO [Staging].[PM_Pharmacy_DynamicsETL](PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription
	, AccountName, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus, CardinalDC
	, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email
	, EmergencyPhone, EstMonthlyVol, FedID, GroupNo, Hours, IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM, StoreHours_MondayFridayAM
	, StoreHours_MondayFridayPM, StoreHours_SaturdayAM, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated
	, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler, QPS, Rank, Resigned, Source, Status, Territory, UDAccountNo, UDNonPharmacy, UDParentNo
	, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created
	, Modified, RowVersion, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
	, CommunicationPreference, APIPaymentMode, AAPPaymentMode, NCPA, OptOutNCPA, ReasonNotEligibleNCPA)
	SELECT PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription
	, AccountName, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus, CardinalDC
	, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email
	, EmergencyPhone, EstMonthlyVol, FedID, GroupNo, Hours, IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM, StoreHours_MondayFridayAM
	, StoreHours_MondayFridayPM, StoreHours_SaturdayAM, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated
	, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler, QPS, Rank, Resigned, Source, Status, Territory, UDAccountNo, UDNonPharmacy, UDParentNo
	, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created
	, Modified, RowVersion, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
	, CommunicationPreference, APIPaymentMode, AAPPaymentMode, NCPA, OptOutNCPA, ReasonNotEligibleNCPA
	FROM Staging.PM_Pharmacy
	WHERE PMID IS NOT NULL

	SET IDENTITY_INSERT dbo.PM_Pharmacy OFF

END
GO
