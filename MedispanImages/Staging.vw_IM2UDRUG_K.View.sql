USE [MedispanImages]
GO
/****** Object:  View [Staging].[vw_IM2UDRUG_K]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_IM2UDRUG_K]

AS

SELECT Unique_Drug_ID
	, CASE 
       WHEN Transaction_Code NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Transaction_Code
       END AS Transaction_Code
	, Dosage_Form_ID
	, External_Drug_ID
	, Manufacturer_ID
	, CASE 
       WHEN Reserve NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Reserve
       END AS Reserve
	FROM [MedispanImages_Staging].[dbo].[IM2UDRUG_K]
GO
