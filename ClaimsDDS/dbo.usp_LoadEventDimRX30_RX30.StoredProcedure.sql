USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_LoadEventDimRX30_RX30]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_LoadEventDimRX30_RX30]

 @Date DATETIME


AS

SET NOCOUNT ON;

BEGIN

SELECT  cast(CONVERT(varchar(20), dt.DateOfService, 112) as INT) AS DateKey
, dt.ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, QuantityDispensed, DaysSupply
	, NDC, BasisOfSubmission, OtherCoverageCode, DAW, DAWDescription, PlanID, RejectCode, RejectCodeDescription, MessageResponse, TransactionResponseStatus
	, PrescriptionNumber, RefillNumberCode, RefillNumberCodeDescription, ProviderIDQualifier, ProviderID, DoctorName, NumberOfRefillsAuthorized, NDC_As_Written
	, PayerType, PharmacySystemLicenseNumber, CompoundCode, CompoundCodeDescription, NetworkReimbursementID, PrescriptionOriginCode, PhysicianDEA, PrescriberNPI
	, AuthorizationNumber, GenericProductIndicator, GenericContractNumber, Manufacturer, ContractType, DrugDescription, Form, Size, Strength, FileProcessed
	, RowCreatedDate, RowUpdatedDate, RowVersionID, DateSold, dt.[OldEventDimPk]
FROM(SELECT ROW_NUMBER() OVER( PARTITION BY ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, QuantityDispensed, DaysSupply
							, NDC, BasisOfSubmission, OtherCoverageCode, DAW, DAWDescription, PlanID, RejectCode, RejectCodeDescription, MessageResponse, TransactionResponseStatus
							, PrescriptionNumber, RefillNumberCode, RefillNumberCodeDescription, ProviderIDQualifier, ProviderID, DoctorName, NumberOfRefillsAuthorized, NDC_As_Written
							, PayerType, PharmacySystemLicenseNumber, CompoundCode, CompoundCodeDescription, NetworkReimbursementID, PrescriptionOriginCode, PhysicianDEA, PrescriberNPI
							, AuthorizationNumber, GenericProductIndicator, GenericContractNumber, Manufacturer, ContractType, DrugDescription, Form, Size, Strength, DateSold
							ORDER BY(SELECT NULL)
							) AS RN
	, ServiceProviderID, BINNumber, ProcessorControlNumber, GroupID, ClaimSubmittedDate, DateOfService, QuantityDispensed, DaysSupply
	, NDC, BasisOfSubmission, OtherCoverageCode, DAW, DAWDescription, PlanID, RejectCode, RejectCodeDescription, MessageResponse, TransactionResponseStatus
	, PrescriptionNumber, RefillNumberCode, RefillNumberCodeDescription, ProviderIDQualifier, ProviderID, DoctorName, NumberOfRefillsAuthorized, NDC_As_Written
	, PayerType, PharmacySystemLicenseNumber, CompoundCode, CompoundCodeDescription, NetworkReimbursementID, PrescriptionOriginCode, PhysicianDEA, PrescriberNPI
	, AuthorizationNumber, GenericProductIndicator, GenericContractNumber, Manufacturer, ContractType, DrugDescription, Form, Size, Strength, FileProcessed
	, RowCreatedDate, RowUpdatedDate, RowVersionID, DateSold, [EventKey] AS [OldEventDimPk]
	FROM RX30.[dbo].[EventDim]
	WHERE [DateOfService] = @Date
	) AS dt
WHERE dt.RN = 1

END
GO
