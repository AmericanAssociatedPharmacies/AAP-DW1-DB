USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_Load_PM_Pharmacy_PharmacyMasterETL]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Load_PM_Pharmacy_PharmacyMasterETL]

AS

SET NOCOUNT ON;

BEGIN

	BEGIN TRY

		BEGIN TRAN

		--Truncate Staging table
		TRUNCATE TABLE [Staging].[PM_Pharmacy]

		--Need to use this statement because PMID is an IDENTITY column
		SET IDENTITY_INSERT [Staging].[PM_Pharmacy] ON 

		--Insert rows
		INSERT INTO [Staging].[PM_Pharmacy](PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup
											, AAPQuitDate, AAPStatus, AccountDescription, AccountName, AllowDupDEA, APIAccountNo
											, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus
											, CardinalDC, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName
											, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email, EmergencyPhone, EstMonthlyVol, FedID
											, GroupNo, HolidayHours, [Hours], IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM
											, StoreHours_MondayFridayAM, StoreHours_MondayFridayPM, StoreHours_SaturdayAM
											, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore
											, NCPDP, NPI, NumReactivated, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler
											, QPS, [Rank], Resigned, [Source], [Status], Territory, UDAccountNo, UDNonPharmacy, UDParentNo, UDQuitDate
											, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, IsPva
											, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created, Modified, [RowVersion]
											, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM
											, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
											, CommunicationPreference, APIPaymentMode, AAPPaymentMode
											, NCPA, OptOutNCPA, ReasonNotEligibleNCPA
											)
		SELECT PMID, PMParentID, AAPAccountNo, AAPEffectiveDate, AAPParentNo, AAPPreviousGroup
		, AAPQuitDate, AAPStatus, AccountDescription, AccountName, AllowDupDEA, APIAccountNo
		, APIDEA, APIMemberNo, APIPMID, APIStatus, AvgWholesaleVolume, BusinessClass, CAHStatus
		, CardinalDC, CategoryID, CompetitiveAcct, ComputerSoftware, ContractDate, CorporateName
		, CustPayTermsAPI, DateOpened, DBA, DEA, DEAEXP, Email, EmergencyPhone, EstMonthlyVol, FedID
		, GroupNo, HolidayHours, [Hours], IsHighVolume, StoreHours_HolidayAM, StoreHours_HolidayPM
		, StoreHours_MondayFridayAM, StoreHours_MondayFridayPM, StoreHours_SaturdayAM
		, StoreHours_SaturdayPM, StoreHours_SundayAM, StoreHours_SundayPM, IsStartUpStore
		, NCPDP, NPI, NumReactivated, OrigStartDate, OwnerName, Payee_id, PrimaryCAAccountNo, PrimaryWholesaler
		, QPS, [Rank], Resigned, [Source], [Status], Territory, UDAccountNo, UDNonPharmacy, UDParentNo, UDQuitDate
		, UDStatus, Website, Wholesaler, WholesalerAccountNo, WhyResigned, IsBuyingGroup, IsPos, IsPva
		, FeePaid, IsManagedCare, IsWarehouse, IsNPP, ACHEmail, Created, Modified, [RowVersion]
		, MembershipType, OrganizationType, AuthorizedVoter, MembershipOwner, WHSNUM
		, PlansExcluded, IsClaimData, IsUPCData, MedicarePartBNo, DoNotFax
		, CommunicationPreference, APIPaymentMode, AAPPaymentMode
		, NCPA, OptOutNCPA, ReasonNotEligibleNCPA
		FROM ODSIntake.[Staging].[PM_Pharmacy]

		--Turn off IDENTITY_INSERT
		SET IDENTITY_INSERT [Staging].[PM_Pharmacy] OFF

		--Truncate archive table
		TRUNCATE TABLE [Archive].[PM_Pharmacy]

		--Switch current data to Archive table
		ALTER TABLE dbo.PM_Pharmacy
		SWITCH TO Archive.PM_Pharmacy

		--Switch in current data 
		ALTER TABLE Staging.PM_Pharmacy
		SWITCH TO dbo.PM_Pharmacy

	COMMIT TRAN

	END TRY
	BEGIN CATCH

		--Rollback tran if any error occurs. This must be an explicit statement due to TRUNCATE TABLE statements being used.
		ROLLBACK TRAN

		DECLARE @ERROR_MESSAGE VARCHAR(4000)

		SELECT @ERROR_MESSAGE = ERROR_MESSAGE()

		EXEC msdb.dbo.sp_send_dbmail  
		@profile_name = 'AAPDW1 mail',  
		@recipients = 'scott.edwards@rxaap.com; yodi.haile@rxaap.com',  
		@body = @ERROR_MESSAGE,  
		@subject = 'PharmacyMaster ETL' ;  

	END CATCH

END
GO
