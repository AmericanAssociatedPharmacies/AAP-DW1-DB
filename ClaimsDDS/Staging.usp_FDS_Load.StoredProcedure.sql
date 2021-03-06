USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_FDS_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [Staging].[usp_FDS_Load]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

		
	SELECT DateKey, PharmacyKey, ClaimStatusCode, ClaimStatusCodeDescription, ServiceProviderIDQualifier, ServiceProviderIDQualifierDescription, ServiceProviderID
	, TransactionDate, PrescriptionNumber, RefillNumber, FillDate, DispensedProductQualifier, DispensedProductQualifierDescription, DispensedProductID, PayerSequence
	, PayerSequenceDescription, BIN, PCN, GroupNumber, InsurerCode, InsurerName, PlanCode, PlanName, PrescriberQualifier, PrescriberQualifierDescription
	, PrescriberSubmittedID, PrescriberLastName, PrescriberFirstName, PrescriberStreetAddress, PrescriberCity, PrescriberStateCode, PrescriberZipCode, PrescriberPhoneNumber
	, OrigininallyPrescribedProduct, PrescribedRefills, RXExpirationDate, DAW, DAWDescription, DateWritten, OriginCode, OriginCodeDescription, CompoundCode
	, CompoundCodeDescripiton, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted
	, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, BasisCostCode, BasisCostCodeDescription
	, QuantityDispensed, DaysSupply, PharmacistInitials, RejectMessageCount, RejectMessages, AuthNumber, BasisOfReimbursementDetermination
	, BasisOfReimbursementDeterminationDescription, PlaceOfService, PlaceOfServiceDescription, ProviderIDQualifier, ProviderIDQualifierDescription, ProviderID
	, AdjustedContractCost, Is340BClaim, PrescriptionStatus, PrescriptionStatusDescription, ProductSource, FileProcessed, RowversionID, PMID, CorrectedPMID
	, [OtherAmountPaid], [eVoucherAmountPaid]
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY [ClaimStatusCode], [ServiceProviderID], DateKey, [PrescriptionNumber], [RefillNumber], [DispensedProductID],PayerSequence, BIN, AuthNumber ORDER BY DateKey ASC) AS RN
	, DateKey, PharmacyKey, ClaimStatusCode, ClaimStatusCodeDescription, ServiceProviderIDQualifier, ServiceProviderIDQualifierDescription, ServiceProviderID
	, TransactionDate, PrescriptionNumber, RefillNumber, FillDate, DispensedProductQualifier, DispensedProductQualifierDescription, DispensedProductID, PayerSequence
	, PayerSequenceDescription, BIN, PCN, GroupNumber, InsurerCode, InsurerName, PlanCode, PlanName, PrescriberQualifier, PrescriberQualifierDescription
	, PrescriberSubmittedID, PrescriberLastName, PrescriberFirstName, PrescriberStreetAddress, PrescriberCity, PrescriberStateCode, PrescriberZipCode, PrescriberPhoneNumber
	, OrigininallyPrescribedProduct, PrescribedRefills, RXExpirationDate, DAW, DAWDescription, DateWritten, OriginCode, OriginCodeDescription, CompoundCode
	, CompoundCodeDescripiton, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted
	, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, BasisCostCode, BasisCostCodeDescription
	, QuantityDispensed, DaysSupply, PharmacistInitials, RejectMessageCount, RejectMessages, AuthNumber, BasisOfReimbursementDetermination
	, BasisOfReimbursementDeterminationDescription, PlaceOfService, PlaceOfServiceDescription, ProviderIDQualifier, ProviderIDQualifierDescription, ProviderID
	, AdjustedContractCost, Is340BClaim, PrescriptionStatus, PrescriptionStatusDescription, ProductSource, FileProcessed, RowversionID, PMID, CorrectedPMID
	, [OtherAmountPaid], [eVoucherAmountPaid]
	FROM [Staging].[vwFDS]
	WHERE DateKey = @DateKey
	) AS dt
	WHERE dt.RN = 1
	AND NOT EXISTS(SELECT 1
					FROM dbo.EventDimFDS AS b (NOLOCK)
					WHERE ISNULL(dt.ClaimStatusCode,'') = ISNULL(b.ClaimStatusCode,'')
					AND ISNULL(dt.ServiceProviderID,'') =  ISNULL(b.ServiceProviderID,'')
					AND dt.DateKey = b.Datekey
					AND ISNULL(dt.PrescriptionNumber,'') = ISNULL(b.[PrescriptionNumber],'')
					AND ISNULL(dt.BIN,'') = ISNULL(b.BIN,'')
					AND ISNULL(dt.PayerSequence,'') = ISNULL(b.PayerSequence,'')
					AND ISNULL(dt.AuthNumber,'') = ISNULL(b.AuthNumber,'')
					)
	
	

END











GO
