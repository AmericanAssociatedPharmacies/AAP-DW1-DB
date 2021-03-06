USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_MedicaidInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_NCPDP_MedicaidInformation]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
, SUBSTRING(C1,8,2) AS StateCode
, NULLIF(SUBSTRING(C1,10,20), '') AS MedicaidID
, NULLIF(SUBSTRING(C1,30,8), '') AS DeleteDate
FROM(SELECT MIN(RowID) AS MinRowID
	, MAX(RowID) AS MaxRowID
	FROM ODSIntake.[Staging].[NCPDP_MedicaidInformation]
	) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_MedicaidInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID
GO
