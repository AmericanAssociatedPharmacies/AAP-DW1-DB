USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDSDups_ExactDups]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_FDSDups_ExactDups]

	@DateKey INT


AS


SET NOCOUNT ON;

BEGIN

	SELECT dt.RN
	, dt.EventKey
	FROM(SELECT CONVERT(INT,ROW_NUMBER() OVER(PARTITION BY ClaimStatusCode, ClaimStatusCodeDescription, ServiceProviderIDQualifier, ServiceProviderIDQualifierDescription, ServiceProviderID, TransactionDate, PrescriptionNumber, FillDate
												, DispensedProductQualifier, DispensedProductQualifierDescription, DispensedProductID, PayerSequence, PayerSequenceDescription, BIN, PCN, GroupNumber, InsurerCode, InsurerName, PlanCode, PlanName
												, PrescriberQualifier, PrescriberQualifierDescription, PrescriberSubmittedID, PrescriberLastName, PrescriberFirstName, PrescriberStreetAddress, PrescriberCity, PrescriberZipCode, PrescriberPhoneNumber
												, OriginallyPrescribedProduct, RXExpirationDate, DAW, DAWDescription, DateWritten, OriginCode, OriginCodeDescription, CompoundCode, CompoundCodeDescripiton, BasisCostCode, BasisCostCodeDescription
												, PharmacistInitials, RejectMessageCount, RejectMessages, AuthNumber, BasisOfReimbursementDetermination, BasisOfReimbursementDeterminationDescription, PlaceOfService, PlaceOfServiceDescription
												, ProviderIDQualifier, ProviderIDQualifierDescription, Is340BClaim, PrescriptionStatus, PrescriptionStatusDescription, ProductSource, PMID 
												, cf.PrescribedRefills, cf.RefillNumber, cf.TotalQuantity, cf.ContractCost, cf.AWP, UandC, cf.CopayAmountSubmitted, cf.IngredientCostSubmitted, cf.DispensingFeeSubmitted, cf.IncentiveFeeSubmitted, cf.SalesTaxSubmitted
												, cf.CopayAmountPaid, cf.IngredientCostPaid, cf.DispensingFeePaid, cf.SalesTaxPaid, cf.IncentiveFeePaid, cf.ClaimAmountPaid, cf.QuantityDispensed, cf.DaysSupply, cf.AdjustedContractCost												
												ORDER BY(SELECT NULL))) AS RN
		, e.EventKey
		FROM dbo.EventDimFDS AS e
		INNER JOIN dbo.ClaimFactFDS AS cf ON e.EventKey = cf.EventKey
		WHERE cf.DateofServiceKey = @DateKey
		) AS dt
	WHERE dt.RN > 1


END

GO
