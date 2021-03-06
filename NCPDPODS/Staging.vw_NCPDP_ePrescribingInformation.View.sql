USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ePrescribingInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_ePrescribingInformation]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
, SUBSTRING(C1,8,10) AS ePrescribingNetworkIdentifier
, NULLIF(SUBSTRING(C1,11,100), '') AS ePrescribingServiceLevelCodes
, NULLIF(SUBSTRING(C1,111,8), '') AS EffectiveFromDate
, NULLIF(SUBSTRING(C1,119,8), '') AS EffectiveThroughDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_EPrescribingInformation]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_EPrescribingInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
