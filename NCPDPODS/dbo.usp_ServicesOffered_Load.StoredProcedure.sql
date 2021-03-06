USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ServicesOffered_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_ServicesOffered_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[ServicesOffered] AS T
	USING (SELECT [NCPDPProviderID], [AcceptsePrescriptionsIndicator], [AcceptsePrescriptionsCode], [DeliveryServiceIndicator], [DeliveryServiceCode], [CompoundingServiceIndicator], [CompoundingServiceCode]
				, [DriveUpWindowIndicator], [DriveUpWindowCode], [DurableMedicalEquipmentIndicator], [DurableMedicalEquipmentCode], [WalkInClinicIndicator], [WalkInClinicCode], [24HourEmergencyServiceIndicator]
				, [24HourEmergencyServiceCode], [MultiDoseCompliancePackagingIndicator], [MultiDoseCompliancePackagingCode], [ImmunizationsProvidedIndicator], [ImmunizationsProvidedCode]
				, [HandicappedAccessibleIndicator], [HandicappedAccessibleCode], [340BStatusIndicator], [340BStatusCode], [ClosedDoorFacilityIndicator], [ClosedDoorFacilityStatusCode]
		   FROM [Staging].[vw_NCPDP_ServicesOffered]) AS S
				([NCPDPProviderID], [AcceptsePrescriptionsIndicator], [AcceptsePrescriptionsCode], [DeliveryServiceIndicator], [DeliveryServiceCode], [CompoundingServiceIndicator], [CompoundingServiceCode]
			   , [DriveUpWindowIndicator], [DriveUpWindowCode], [DurableMedicalEquipmentIndicator], [DurableMedicalEquipmentCode], [WalkInClinicIndicator], [WalkInClinicCode], [24HourEmergencyServiceIndicator]
			   , [24HourEmergencyServiceCode], [MultiDoseCompliancePackagingIndicator], [MultiDoseCompliancePackagingCode], [ImmunizationsProvidedIndicator], [ImmunizationsProvidedCode]
			   , [HandicappedAccessibleIndicator], [HandicappedAccessibleCode], [340BStatusIndicator], [340BStatusCode], [ClosedDoorFacilityIndicator], [ClosedDoorFacilityStatusCode])
		  ON T.[NCPDPProviderID] = S.[NCPDPProviderID]
WHEN MATCHED THEN

UPDATE SET [AcceptsePrescriptionsIndicator] = S.[AcceptsePrescriptionsIndicator]
		 , [AcceptsePrescriptionsCode] = S.[AcceptsePrescriptionsCode]
		 , [DeliveryServiceIndicator] = S.[DeliveryServiceIndicator]
		 , [DeliveryServiceCode] = S.[DeliveryServiceCode]
		 , [CompoundingServiceIndicator] = S.[CompoundingServiceIndicator]
		 , [CompoundingServiceCode] = S.[CompoundingServiceCode]
		 , [DriveUpWindowIndicator] = S.[DriveUpWindowIndicator]
		 , [DriveUpWindowCode] = S.[DriveUpWindowCode]
		 , [DurableMedicalEquipmentIndicator] = S.[DurableMedicalEquipmentIndicator]
		 , [DurableMedicalEquipmentCode] = S.[DurableMedicalEquipmentCode]
		 , [WalkInClinicIndicator] = S.[WalkInClinicIndicator]
		 , [WalkInClinicCode] = S.[WalkInClinicCode]
		 , [24HourEmergencyServiceIndicator] = S.[24HourEmergencyServiceIndicator]
		 , [24HourEmergencyServiceCode] = S.[24HourEmergencyServiceCode]
		 , [MultiDoseCompliancePackagingIndicator] = S.[MultiDoseCompliancePackagingIndicator]
		 , [MultiDoseCompliancePackagingCode] = S.[MultiDoseCompliancePackagingCode]
		 , [ImmunizationsProvidedIndicator] = S.[ImmunizationsProvidedIndicator]
		 , [ImmunizationsProvidedCode] = S.[ImmunizationsProvidedCode]
		 , [HandicappedAccessibleIndicator] = S.[HandicappedAccessibleIndicator]
		 , [HandicappedAccessibleCode] = S.[HandicappedAccessibleCode]
		 , [340BStatusIndicator] = S.[340BStatusIndicator]
		 , [340BStatusCode] = S.[340BStatusCode]
		 , [ClosedDoorFacilityIndicator] = S.[ClosedDoorFacilityIndicator]
		 , [ClosedDoorFacilityStatusCode] = S.[ClosedDoorFacilityStatusCode]

WHEN NOT MATCHED THEN
		INSERT ([NCPDPProviderID], [AcceptsePrescriptionsIndicator], [AcceptsePrescriptionsCode], [DeliveryServiceIndicator], [DeliveryServiceCode], [CompoundingServiceIndicator], [CompoundingServiceCode]
				, [DriveUpWindowIndicator], [DriveUpWindowCode], [DurableMedicalEquipmentIndicator], [DurableMedicalEquipmentCode], [WalkInClinicIndicator], [WalkInClinicCode], [24HourEmergencyServiceIndicator]
				, [24HourEmergencyServiceCode], [MultiDoseCompliancePackagingIndicator], [MultiDoseCompliancePackagingCode], [ImmunizationsProvidedIndicator], [ImmunizationsProvidedCode]
				, [HandicappedAccessibleIndicator], [HandicappedAccessibleCode], [340BStatusIndicator], [340BStatusCode], [ClosedDoorFacilityIndicator], [ClosedDoorFacilityStatusCode])
		VALUES (S.[NCPDPProviderID], S.[AcceptsePrescriptionsIndicator], S.[AcceptsePrescriptionsCode], S.[DeliveryServiceIndicator], S.[DeliveryServiceCode], S.[CompoundingServiceIndicator], S.[CompoundingServiceCode]
				, S.[DriveUpWindowIndicator], S.[DriveUpWindowCode], S.[DurableMedicalEquipmentIndicator], S.[DurableMedicalEquipmentCode], S.[WalkInClinicIndicator], S.[WalkInClinicCode], S.[24HourEmergencyServiceIndicator]
				, S.[24HourEmergencyServiceCode], S.[MultiDoseCompliancePackagingIndicator], S.[MultiDoseCompliancePackagingCode], S.[ImmunizationsProvidedIndicator], S.[ImmunizationsProvidedCode]
				, S.[HandicappedAccessibleIndicator], S.[HandicappedAccessibleCode], S.[340BStatusIndicator], S.[340BStatusCode], S.[ClosedDoorFacilityIndicator], S.[ClosedDoorFacilityStatusCode]);
END


GO
