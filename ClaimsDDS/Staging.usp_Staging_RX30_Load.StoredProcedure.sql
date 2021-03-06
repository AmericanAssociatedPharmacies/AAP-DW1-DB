USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Staging_RX30_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [Staging].[usp_Staging_RX30_Load]

AS

SET NOCOUNT ON;

BEGIN

	
	SELECT dt.DateKey, dt.ServiceProviderID, dt.BINNumber, dt.ProcessorControlNumber, dt.GroupID, dt.ClaimSubmittedDate, dt.DateOfService, dt.QuantityDispensed, dt.DaysSupply, dt.NDC, dt.BasisOfSubmission
	, dt.DispensingFeeSubmitted, dt.IngredientCostSubmitted, dt.DispensingFeePaid, dt.IngredientCostPaid, dt.TotalAmountPaid, dt.AmountOfCopay, dt.UsualandCustomaryCharge, dt.TotalPrice
	, dt.BasisofReimbursementDetermination, dt.OtherCoverageCode, dt.DAW, dt.DAWDescription, dt.PatientPayAmount, dt.GrossAmountDue, dt.PlanID, dt.RejectCode, dt.MessageResponse
	, dt.TransactionResponseStatus, dt.PrescriptionNumber, dt.RefillNumberCode, dt.ProviderIDQualifier, dt.ProviderID, dt.DoctorName, dt.NumberofRefillsAuthorized, dt.NDCWritten, dt.OtherAmount
	, dt.PayerType, dt.PharmacySystemLicenseNumber, dt.CompoundCode, dt.NetworkReimbursementID, dt.PrescriberPhoneNumber, dt.PrescriptionOriginCode, dt.PhysicianDEA, dt.UnitAWP
	, dt.FlatSalesTaxAmountPaid, dt.PercentageSalesTaxAmountPaid, dt.PercentageSalesTaxRate, dt.PercentageSalesTaxBasisPaid, dt.IncentiveAmountPaid, dt.ProfessionalFeePaid
	, dt.PrescriberNPI, dt.RXDiscount, dt.AuthorizationNumber, dt.FileProcessed, dt.DateSold, dt.RowversionID, dt.PharmacyKey
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY s.RowversionID ORDER BY (SELECT NULL)) AS RN, ISNULL(ISNULL(pd1.PharmacyKey, pd2.PharmacyKey),0) AS PharmacyKey
		, DateKey, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, QuantityDispensed, DaysSupply, NDC, BasisOfSubmission
		, DispensingFeeSubmitted, IngredientCostSubmitted, DispensingFeePaid, IngredientCostPaid, TotalAmountPaid, AmountOfCopay, UsualandCustomaryCharge, TotalPrice
		, BasisofReimbursementDetermination, OtherCoverageCode, DAW, DAWDescription, PatientPayAmount, GrossAmountDue, PlanID, RejectCode, MessageResponse
		, TransactionResponseStatus, PrescriptionNumber, RefillNumberCode, ProviderIDQualifier, ProviderID, DoctorName, NumberofRefillsAuthorized, NDCWritten, OtherAmount
		, PayerType, PharmacySystemLicenseNumber, CompoundCode, NetworkReimbursementID, PrescriberPhoneNumber, PrescriptionOriginCode, PhysicianDEA, UnitAWP
		, FlatSalesTaxAmountPaid, PercentageSalesTaxAmountPaid, PercentageSalesTaxRate, PercentageSalesTaxBasisPaid, IncentiveAmountPaid, ProfessionalFeePaid
		, PrescriberNPI, RXDiscount, AuthorizationNumber, FileProcessed, DateSold, s.RowversionID, s.EndDateKey
		FROM [Staging].[vwRX30] AS s
		LEFT OUTER JOIN dbo.PharmacyDim AS pd1 ON pd1.[NCPDP] = s.ServiceProviderID
													AND s.DateKey BETWEEN pd1.AAPEffectiveDateKey AND pd1.AAPQuitDateKey
		LEFT OUTER JOIN dbo.PharmacyDim AS pd2 ON pd2.[NPI] = s.ServiceProviderID
													AND s.DateKey BETWEEN pd2.AAPEffectiveDateKey AND pd2.AAPQuitDateKey
		) AS dt
	WHERE dt.RN = 1


END



GO
