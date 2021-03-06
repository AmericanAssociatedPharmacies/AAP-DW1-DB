USE [MedispanImages]
GO
/****** Object:  View [Staging].[vw_IM2DMFG_M]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vw_IM2DMFG_M]

AS

SELECT Manufacturer_ID
	, CASE 
       WHEN Transaction_Code NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Transaction_Code
       END AS Transaction_Code
	, Manufacturer_Name
	, CASE 
       WHEN Reserve NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Reserve
       END AS Reserve
	FROM [MedispanImages_Staging].[dbo].[IM2DMFG_M]
GO
