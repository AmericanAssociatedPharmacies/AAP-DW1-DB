USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [Staging].[usp_PM_Pharmacy_DynamicsETL_Load]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_PM_Pharmacy_DynamicsETL_Load]

AS

SET NOCOUNT ON;

BEGIN


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
	FROM Staging.vw_PM_Pharmacy
	WHERE PMID IS NOT NULL

END
GO
