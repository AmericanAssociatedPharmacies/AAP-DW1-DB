USE [MedispanImages]
GO
/****** Object:  View [Staging].[vw_IM2VAL_D]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_IM2VAL_D]

AS

SELECT Field_Identifier, Field_Value, Language_Code, Value_Description
	, CASE 
       WHEN Value_Abbreviation NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Value_Abbreviation
       END AS Value_Abbreviation
	, CASE 
       WHEN Reserve NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
       ELSE Reserve
       END AS Reserve
	FROM [MedispanImages_Staging].[dbo].[IM2VAL_D]
GO
