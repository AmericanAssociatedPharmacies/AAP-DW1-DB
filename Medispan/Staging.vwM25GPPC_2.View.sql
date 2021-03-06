USE [Medispan]
GO
/****** Object:  View [Staging].[vwM25GPPC_2]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vwM25GPPC_2]

AS

SELECT CONVERT(VARCHAR(8), LTRIM(RTRIM(Generic_Product_Packaging_Code))) AS [Generic_Product_Packaging_Cod]
, CONVERT(NUMERIC(8,3), Package_Size) AS [Package_Size]
, CONVERT(VARCHAR(8), LTRIM(RTRIM(Package_Size_Unit_of_Measure))) AS [Package_Size_Unit_of_Measure]
, CONVERT(NUMERIC(37,0), Package_Quantity) AS [Package_Quantity]
, CASE 
	WHEN CONVERT(VARCHAR(1), LTRIM(RTRIM(Unit_DoseUnit_of_Use_Package)))  NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE CONVERT(VARCHAR(1), LTRIM(RTRIM(Unit_DoseUnit_of_Use_Package)))
	END AS [Unit_Dose_Unit_of_Use_Package]
, CONVERT(VARCHAR(2), LTRIM(RTRIM(Package_Description_Code))) AS [Package_Description_Code]
, CONVERT(VARCHAR(14), LTRIM(RTRIM(Generic_Product_Identifier))) AS [Generic_Product_Identifier]
, NULL AS Transaction_Code
, CONVERT(VARCHAR(8), LTRIM(RTRIM(Last_Change_Date))) AS [Last_Change_Date]
, CONVERT(VARCHAR(15), LTRIM(RTRIM(Reserve))) AS [Reserve]
FROM Medispan_Staging.dbo.MF2GPPC_J
GO
