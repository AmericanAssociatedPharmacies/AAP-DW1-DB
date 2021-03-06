USE [NCPDPODS]
GO
/****** Object:  View [Staging].[vw_NCPDP_Taxonomy]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_NCPDP_Taxonomy]

AS

SELECT SUBSTRING(C1,1,7) AS NCPDPProviderID
, NULLIF(SUBSTRING(C1,8,10), '') AS TaxonomyCode
, NULLIF(SUBSTRING(C1,18,2), '') AS ProviderTypeCode 
, NULLIF(SUBSTRING(C1,20,8), '') AS DeleteDate 
FROM(SELECT MIN(RowID) AS MinRowID
       , MAX(RowID) AS MaxRowID
       FROM ODSIntake.[Staging].[NCPDP_Taxonomy]
       ) AS dt
INNER JOIN ODSIntake.[Staging].[NCPDP_Taxonomy] AS s ON s.RowID > dt.MinRowID
                                                     AND s.RowID < dt.MaxRowID
GO
