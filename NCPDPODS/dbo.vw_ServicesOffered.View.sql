USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_ServicesOffered]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ServicesOffered]

AS


SELECT ServicesKey, NCPDPProviderID, AcceptsePrescriptionsIndicator, AcceptsePrescriptionsCode, DeliveryServiceIndicator
, DeliveryServiceCode, CompoundingServiceIndicator, CompoundingServiceCode, DriveUpWindowIndicator, DriveUpWindowCode
, DurableMedicalEquipmentIndicator, DurableMedicalEquipmentCode, WalkInClinicIndicator, WalkInClinicCode, 24HourEmergencyServiceIndicator
, 24HourEmergencyServiceCode, MultiDoseCompliancePackagingIndicator, MultiDoseCompliancePackagingCode, ImmunizationsProvidedIndicator
, ImmunizationsProvidedCode, HandicappedAccessibleIndicator, HandicappedAccessibleCode, 340BStatusIndicator, 340BStatusCode, ClosedDoorFacilityIndicator
, ClosedDoorFacilityStatusCode, RowCreatedDate
FROM [dbo].[ServicesOffered]
GO
