USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_StateLicense]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_StateLicense]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDpProviderID
, SUBSTRING(C1,8,2) AS LicenseStateCode
, NULLIF(SUBSTRING(C1,10,20), '') AS StateLicesnseNumber
, NULLIF(SUBSTRING(C1,30,8), '') AS StateLicenseExpirationDate
, NULLIF(SUBSTRING(C1,38,8), '') AS DeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_StateLicense]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_StateLicense] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
