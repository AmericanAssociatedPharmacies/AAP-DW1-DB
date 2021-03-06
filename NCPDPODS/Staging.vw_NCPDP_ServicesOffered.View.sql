USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ServicesOffered]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_NCPDP_ServicesOffered]

AS


SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
, NULLIF(SUBSTRING(C1,8,1), '') AS AcceptsePrescriptionsIndicator  
, NULLIF(SUBSTRING(C1,9,2), '') AS AcceptsePrescriptionsCode 
, NULLIF(SUBSTRING(C1,11,1), '') AS DeliveryServiceIndicator 
, NULLIF(SUBSTRING(C1,12,2), '') AS DeliveryServiceCode
, NULLIF(SUBSTRING(C1,14,1), '') AS CompoundingServiceIndicator 
, NULLIF(SUBSTRING(C1,15,2), '') AS CompoundingServiceCode  
, NULLIF(SUBSTRING(C1,17,1), '') AS DriveUpWindowIndicator 
, NULLIF(SUBSTRING(C1,18,2), '') AS DriveUpWindowCode
, NULLIF(SUBSTRING(C1,20,1), '') AS DurableMedicalEquipmentIndicator
, NULLIF(SUBSTRING(C1,21,2), '') AS DurableMedicalEquipmentCode
, NULLIF(SUBSTRING(C1,23,1), '') AS WalkInClinicIndicator
, NULLIF(SUBSTRING(C1,24,2), '') AS WalkInClinicCode
, NULLIF(SUBSTRING(C1,26,1), '') AS [24HourEmergencyServiceIndicator] 
, NULLIF(SUBSTRING(C1,27,2), '') AS [24HourEmergencyServiceCode]
, NULLIF(SUBSTRING(C1,29,1), '') AS MultiDoseCompliancePackagingIndicator
, NULLIF(SUBSTRING(C1,30,2), '') AS MultiDoseCompliancePackagingCode 
, NULLIF(SUBSTRING(C1,32,1), '') AS ImmunizationsProvidedIndicator 
, NULLIF(SUBSTRING(C1,33,2), '') AS ImmunizationsProvidedCode 
, NULLIF(SUBSTRING(C1,35,1), '') AS HandicappedAccessibleIndicator 
, NULLIF(SUBSTRING(C1,36,2), '') AS HandicappedAccessibleCode 
, NULLIF(SUBSTRING(C1,38,1), '') AS [340BStatusIndicator]
, NULLIF(SUBSTRING(C1,39,2), '') AS [340BStatusCode]
, NULLIF(SUBSTRING(C1,41,1), '') AS ClosedDoorFacilityIndicator 
, NULLIF(SUBSTRING(C1,42,2), '') AS ClosedDoorFacilityStatusCode 
FROM(SELECT MIN(RowID) AS MinRowID
       , MAX(RowID) AS MaxRowID
       FROM ODSIntake.[Staging].[NCPDP_ServicesOffered]
       ) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_ServicesOffered] AS s ON s.RowID > dt.MinRowID
                                                                                         AND s.RowID < dt.MaxRowID
GO
