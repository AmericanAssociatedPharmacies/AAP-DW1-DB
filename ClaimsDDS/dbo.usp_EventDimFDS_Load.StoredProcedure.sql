USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimFDS_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[usp_EventDimFDS_Load]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT Datekey, ClaimStatusCode, ClaimStatusCodeDescription, ServiceProviderIDQualifier, ServiceProviderIDQualifierDescription, ServiceProviderID, TransactionDate
	, PrescriptionNumber, FillDate, DispensedProductQualifier, DispensedProductQualifierDescription, DispensedProductID, PayerSequence
	, PayerSequenceDescription, BIN, PCN, GroupNumber, InsurerCode, InsurerName, PlanCode, PlanName, PrescriberQualifier, PrescriberQualifierDescription
	, PrescriberSubmittedID, PrescriberLastName, PrescriberFirstName, PrescriberStreetAddress, PrescriberCity, PrescriberZipCode, PrescriberPhoneNumber
	, OriginallyPrescribedProduct, RXExpirationDate, DAW, DAWDescription, DateWritten, OriginCode, OriginCodeDescription, CompoundCode, CompoundCodeDescripiton
	, BasisCostCode, BasisCostCodeDescription, PharmacistInitials, RejectMessageCount, RejectMessages, AuthNumber, BasisOfReimbursementDetermination
	, BasisOfReimbursementDeterminationDescription, PlaceOfService, PlaceOfServiceDescription, ProviderIDQualifier, ProviderIDQualifierDescription
	, Is340BClaim, PrescriptionStatus, PrescriptionStatusDescription, ProductSource, FileProcessed, RowversionID, RowCreatedDate, PMID, CorrectedPMID
	FROM Staging.FDS AS s
	WHERE DateKey =  @DateKey
	AND NOT EXISTS(SELECT 1
					FROM dbo.EventDimFDS AS e (NOLOCK)
					WHERE s.RowversionID = e.RowversionID
					)

END




GO
