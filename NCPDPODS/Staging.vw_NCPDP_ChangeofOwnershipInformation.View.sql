USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_ChangeofOwnershipInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Staging].[vw_NCPDP_ChangeofOwnershipInformation]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
	, SUBSTRING(C1,8,7) AS OldNCPDPProviderID
	, NULLIF(SUBSTRING(C1,15,8), '') AS OldStoreCloseDate
	, NULLIF(SUBSTRING(C1,23,8), '') AS ChangeofOwnershipEffectiveDate	
FROM (SELECT MIN(RowID) AS MinRowID
	  , MAX(RowID) AS MaxRowID
	 FROM [ODSIntake].[Staging].[NCPDP_ChangeofOwnershipInformation]
	 ) AS dt
INNER JOIN [ODSIntake].[Staging].[NCPDP_ChangeofOwnershipInformation] AS s ON s.RowID > dt.MinRowID
													AND s.RowID < dt.MaxRowID

GO
