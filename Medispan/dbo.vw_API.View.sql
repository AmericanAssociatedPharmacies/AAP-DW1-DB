USE [Medispan]
GO
/****** Object:  View [dbo].[vw_API]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_API]

AS


SELECT A.NDC_UPC_HRI AS NDC
, UPPER(c.Drug_Name) + ' ' + UPPER(c.Dosage_Form) + ' ' + UPPER(c.Strength) + ' ' + UPPER(c.Strength_Unit_of_Measure) AS [Desc]
, CONVERT(VARCHAR(25), LTRIM(RTRIM(
			CASE
			WHEN C.Strength NOT LIKE '%[a-zA-Z0-9]%' THEN ''
			ELSE C.Strength
			END)))AS Strength
, B.Package_Size_Unit_of_Measure AS Unit
, CONVERT(DECIMAL(10,3), B.Package_Size * 1.000) AS Size
, B.Generic_Product_Identifier AS GPI
, G.Unit_Price AS AWP
FROM Medispan_Staging.dbo.MF2NDC_H AS A
LEFT OUTER JOIN Medispan_Staging.dbo.MF2GPPC_J AS B ON A.Generic_Product_Packaging_Code = B.Generic_Product_Packaging_Code
LEFT OUTER JOIN [DrugMaster].dbo.[PackageDescription] AS H ON B.Package_Description_Code = H.PackageCode
LEFT OUTER JOIN Medispan_Staging.dbo.MF2NAME_F AS C ON C.Drug_Descriptor_Identifier = A.Drug_Descriptor_Identifier
LEFT OUTER JOIN Medispan_Staging.dbo.MF2PRC_M AS G ON G.NDC_UPC_HRI = A.NDC_UPC_HRI AND G.Price_Code = 'A'
GO
