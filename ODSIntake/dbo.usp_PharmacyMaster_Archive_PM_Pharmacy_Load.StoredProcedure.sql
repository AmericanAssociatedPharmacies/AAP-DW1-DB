USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_PharmacyMaster_Archive_PM_Pharmacy_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_PharmacyMaster_Archive_PM_Pharmacy_Load]

AS


SET NOCOUNT ON;


BEGIN

	SELECT PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup, AAPQuitDate, AAPStatus, AccountDescription
	, AccountName, AllowDupDEA, APIAccountNo, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus
	, CardinalDC, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName, CustPayTermsAPI, DateOpened, DBA, DEA
	, DEAEXP, Email, EmergencyPhone, EstMonthlyVol, FedID, GroupNo, HolidayHours, [Hours], IsHighVolume, StoreHours_HolidayAM
	, StoreHours_HolidayPM, StoreHours_MondayFridayAM, StoreHours_MondayFridayPM, StoreHours_SaturdayAM, StoreHours_SaturdayPM
	, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore, NCPDP, NPI, NumReactivated, OrigStartDate, OwnerName, Payee_id
	, PrimaryCAAccountNo, PrimaryWholesaler, QPS, [Rank], Resigned, [Source], [Status], Territory, UDAccountNo, UDNonPharmacy, UDParentNo
	, UDQuitDate, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, IsPva, FeePaid, IsManagedCare
	, IsWarehouse, IsNPP, ACHEmail, Created, Modified, [RowVersion], MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner
	, WHSNUM, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax, CommunicationPreference, APIPaymentMode, AAPPaymentMode
	, NCPA, OptOutNCPA, ReasonNotEligibleNCPA, DateKey
	FROM [Staging].[PM_Pharmacy]



END
GO
