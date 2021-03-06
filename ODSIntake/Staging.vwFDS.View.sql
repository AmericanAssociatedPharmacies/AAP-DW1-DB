USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwFDS]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vwFDS]

AS

SELECT RowID
, FileRowID
, [Column0] AS ClaimStatusCode
, [Column1] AS ServiceProviderIDQualifier
, [Column2] AS ServiceProviderID
, [Column3] AS TransactionDate
, [Column4] AS RXNumber
, [Column5] AS RefillNumber
, [Column6] AS FillDate
, [Column7] AS DispensedProductQualifier
, [Column8] AS DispensedProductID
, [Column9] AS PayerSequence
, [Column10] AS BIN
, [Column11] AS PCN
, [Column12] AS GroupNumber
, [Column13] AS InsurerCode
, [Column14] AS InsurerName
, [Column15] AS PlanCode
, [Column16] AS PlanName
, [Column17] AS PrescriberQualifier
, [Column18] AS PrescriberSubmittedID
, [Column19] AS PrescriberLastName
, [Column20] AS PrescriberFirstName
, [Column21] AS PrescriberStreetAddress
, [Column22] AS PrescriberCity
, [Column23] AS PrescriberStateCode
, [Column24] AS PrescriberZipCode
, [Column25] AS PrescriberPhoneNumber
, [Column26] AS OrigininallyPrescribedProduct
, [Column27] AS PrescribedRefills
, [Column28] AS RXExpirationDate
, [Column29] AS DAW
, [Column30] AS DateWritten
, [Column31] AS OriginCode
, [Column32] AS CompoundCode
, [Column33] AS TotalQuantity
, [Column34] AS ContractCost
, [Column35] AS AWP
, [Column36] AS UandC
, [Column37] AS CopayAmountSubmitted
, [Column38] AS IngredientCostSubmitted
, [Column39] AS DispensingFeeSubmitted
, [Column40] AS IncentiveFeeSubmitted
, [Column41] AS SalesTaxSubmitted
, [Column42] AS CopayAmountPaid
, [Column43] AS IngredientCostPaid
, [Column44] AS DispensingFeePaid
, [Column45] AS SalesTaxPaid
, [Column46] AS IncentiveFeePaid
, [Column47] AS ClaimAmountPaid
, [Column48] AS BasisCostCode
, [Column49] AS QuantityDispensed
, [Column50] AS DaysSupply
, [Column51] AS PharmacistInitials
, [Column52] AS RejectMessageCount
, [Column53] AS RejectMessages
, [Column54] AS AuthNumber
, [Column55] AS BasisOfReimbursementDetermination
, [Column56] AS PlaceOfService
, [Column57] AS ProviderIDQualifier
, [Column58] AS ProviderID
, [Column59] AS AdjustedContractCost
, [Column60] AS [340BCode]
, [Column61] AS PrescriptionStatus
, [Column62] AS ProductSource
, [Column63] AS PMID
, FileSource 
, [RowCreatedDate]
, [RowversionID]
FROM Staging.FDS




GO
