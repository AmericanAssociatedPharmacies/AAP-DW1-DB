USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_RX30_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_RX30_Load]

AS

SET NOCOUNT ON;

BEGIN

	TRUNCATE TABLE [Staging].[Rx30];

	INSERT INTO [Staging].[Rx30](FileRowID, DateKey, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, Submitted, DateOfService
	, QuantityDispensed, DaysSupply, NDC, [DispensingFeeSubmited], IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid
	, AmountOfCopay, UsualandCustomaryCharge, TotalPrice, BasisofReimbursementDetermination, OtherCoverageCode, [DispenseAsWritten(DAW)/ProductSelectionCode]
	, DispenseAsWrittenDescription, PatientPayAmount, GrossAmountDue, PlanID, RejectCode, MessageResponse, TransactionResponseStatus, PrescriptionNumber
	, FillNumber, ProviderIDQualifier, ProviderID, DoctorName, NumberofRefillsAuthorized, NDCWritten, OtherAmount, OtherPayerID, PharmacySystemLicenseNumber
	, CompoundCode, NetworkReimbursementID, PrescriberPhoneNumber, PrescriptionOriginCode, DRDEA, UnitAWP, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid
	, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, ProfessionalFeePaid, PrescriberNPI, RXDiscount, AuthorizationNumber, FileProcessed, DateSold
	, RowversionID
	)
	SELECT FileRowID, DateKey, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, Submitted, DateOfService
	, QuantityDispensed, DaysSupply, NDC, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid
	, AmountOfCopay, UsualandCustomaryCharge, TotalPrice, BasisofReimbursementDetermination, OtherCoverageCode, [DispenseAsWritten(DAW)/ProductSelectionCode]
	, DispenseAsWrittenDescription, PatientPayAmount, GrossAmountDue, PlanID, RejectCode, MessageResponse, TransactionResponseStatus, PrescriptionNumber
	, FillNumber, ProviderIDQualifier, ProviderID, DoctorName, NumberofRefillsAuthorized, NDCWritten, OtherAmount, OtherPayerID, PharmacySystemLicenseNumber
	, CompoundCode, NetworkReimbursementID, PrescriberPhoneNumber, PrescriptionOriginCode, DRDEA, UnitAWP, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid
	, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, ProfessionalFeePaid, PrescriberNPI, RXDiscount, AuthorizationNumber, FileProcessed, DateSold
	, RowversionID
	FROM [Staging].[vwRx30]

END

GO
