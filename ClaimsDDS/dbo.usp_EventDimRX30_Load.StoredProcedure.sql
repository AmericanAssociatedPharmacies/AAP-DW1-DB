USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimRX30_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_EventDimRX30_Load]

	--@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	INSERT INTO [dbo].[EventDimRX30](DateKey, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, DaysSupply, NDC
	 , BasisOfSubmission, OtherCoverageCode, DAW, DAWDescription, PlanID, RejectCode, RejectCodeDescription, MessageResponse, TransactionResponseStatus
	 , PrescriptionNumber, RefillNumberCode, RefillNumberCodeDescription, ProviderIDQualifier, ProviderID, DoctorName, NumberOfRefillsAuthorized
	 , NDC_As_Written, PayerType, PharmacySystemLicenseNumber, CompoundCode, CompoundCodeDescription, NetworkReimbursementID, PrescriptionOriginCode
	 , PhysicianDEA, PrescriberNPI, AuthorizationNumber, RowVersionID, DateSold, FileProcessed)
	SELECT DateKey, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, DaysSupply, NDC
	 , BasisOfSubmission, OtherCoverageCode, DAW, DAWDescription, PlanID, RejectCode, NULL AS RejectCodeDescription, MessageResponse, TransactionResponseStatus
	 , PrescriptionNumber, RefillNumberCode, NULL AS RefillNumberCodeDescription, ProviderIDQualifier, ProviderID, DoctorName, NumberOfRefillsAuthorized
	 , NDCWritten, PayerType, PharmacySystemLicenseNumber, CompoundCode, NULL AS CompoundCodeDescription, NetworkReimbursementID, PrescriptionOriginCode
	 , PhysicianDEA, PrescriberNPI, AuthorizationNumber, RowVersionID, DateSold, FileProcessed
	FROM Staging.Rx30
	--WHERE DateKey = @DateKey

	
END


GO
