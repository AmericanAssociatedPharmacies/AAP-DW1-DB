USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimsDDS_FDS_Staging_20191014]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimsDDS_FDS_Staging_20191014]

	@Date INT


AS



BEGIN

	
	SELECT DateKey, PharmacyKey, ClaimStatusCode, ClaimStatusCodeDescription, ServiceProviderIDQualifier, ServiceProviderIDQualifierDescription, ServiceProviderID, TransactionDate, PrescriptionNumber, RefillNumber, FillDate, DispensedProductQualifier, DispensedProductQualifierDescription, DispensedProductID, PayerSequence, PayerSequenceDescription, BIN, PCN, GroupNumber, InsurerCode, InsurerName, PlanCode, PlanName, PrescriberQualifier, PrescriberQualifierDescription, PrescriberSubmittedID, PrescriberLastName, PrescriberFirstName, PrescriberStreetAddress, PrescriberCity, PrescriberStateCode, PrescriberZipCode, PrescriberPhoneNumber, OrigininallyPrescribedProduct, PrescribedRefills, RXExpirationDate, DAW, DAWDescription, DateWritten, OriginCode, OriginCodeDescription, CompoundCode, CompoundCodeDescripiton, TotalQuantity, ContractCost, AWP, UandC, CopayAmountSubmitted, IngredientCostSubmitted, DispensingFeeSubmitted, IncentiveFeeSubmitted, SalesTaxSubmitted, CopayAmountPaid, IngredientCostPaid, DispensingFeePaid, SalesTaxPaid, IncentiveFeePaid, ClaimAmountPaid, BasisCostCode, BasisCostCodeDescription, QuantityDispensed, DaysSupply, PharmacistInitials, RejectMessageCount, RejectMessages, AuthNumber, BasisOfReimbursementDetermination, BasisOfReimbursementDeterminationDescription, PlaceOfService, PlaceOfServiceDescription, ProviderIDQualifier, ProviderIDQualifierDescription, ProviderID, AdjustedContractCost, Is340BClaim, PrescriptionStatus, PrescriptionStatusDescription, ProductSource, FileProcessed, RowversionID, PMID
	FROM [Archive].[vwFDS] AS a
	WHERE NOT EXISTS(SELECT 1
						FROM dbo.EventDimFDS AS b
						WHERE a.RowversionID = b.RowversionID
					)
	AND a.DateKey >= @Date
	



END
GO
