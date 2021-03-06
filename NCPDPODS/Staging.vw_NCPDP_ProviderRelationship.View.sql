USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ProviderRelationship]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_NCPDP_ProviderRelationship]

AS


SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
, NULLIF(SUBSTRING(C1,8,3), '') AS RelationshipID
, NULLIF(SUBSTRING(C1,11,6), '') AS PaymentCenterID
, NULLIF(SUBSTRING(C1,17,6), '') AS RemitandReconciliationID 
, NULLIF(SUBSTRING(C1,23,2), '') AS ProviderType
, NULLIF(SUBSTRING(C1,25,1), '') AS IsPrimary
, NULLIF(SUBSTRING(C1,26,8), '') AS EffectiveFromDate
, NULLIF(SUBSTRING(C1,34,8), '') AS EffectiveThroughDate
FROM(SELECT MIN(RowID) AS MinRowID
       , MAX(RowID) AS MaxRowID
       FROM ODSIntake.[Staging].[NCPDP_ProviderRelationship]
       ) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_ProviderRelationship] AS s ON s.RowID > dt.MinRowID
                                                     AND s.RowID < dt.MaxRowID
GO
