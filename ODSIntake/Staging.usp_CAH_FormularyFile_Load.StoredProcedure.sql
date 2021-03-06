USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_FormularyFile_Load]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [Staging].[usp_CAH_FormularyFile_Load]

AS

SET NOCOUNT ON;

BEGIN

--DECLARE @DateKey INT = 20191104
DECLARE @DateKey INT = CONVERT(INT, CONVERT(VARCHAR(10), GETDATE(), 112))


INSERT INTO [Staging].[CAH_FormularyFile]([DateKey], [CIN], [NDC], [Description], [Supplier Name], [CardKey], [GCN], [GCN_SEQ], [GPI Code], [UD_ID], [Strength], [Accunet Size], [UOM], [Form], [Form Description], [Color]
										, [Shape], [Brand/Generic (CGIC)], [TEE Rating], [DEA Schedule Number], [NIFO], [Sell Price], [Sell Price per Unit], [Generic Name], [Brand Name], [Status], [Formulary Name], [END_DTE])										

SELECT @DateKey AS DateKey
	 , CONVERT(VARCHAR(500),LTRIM(RTRIM(STR(CIN)))) AS CIN
     , LTRIM(RTRIM([NDC])) AS [NDC]
     , LTRIM(RTRIM([Description])) AS [Description]
     , LTRIM(RTRIM([Supplier Name])) AS [Supplier Name]
     , LTRIM(RTRIM([CardKey])) AS [CardKey]
     , LTRIM(RTRIM([GCN])) AS [GCN]
     , LTRIM(RTRIM([GCN_SEQ])) AS [GCN_SEQ]
     , LTRIM(RTRIM([GPI Code])) AS [GPI Code]
     , LTRIM(RTRIM([UD_ID])) AS [UD_ID]
     , LTRIM(RTRIM([Strength])) AS [Strength]
     , LTRIM(RTRIM(CASE 
     	WHEN [Accunet Size] NOT LIKE '%[0-9]%' THEN NULL
     	ELSE [Accunet Size]
     	END
     	)) AS [Accunet Size]
     , LTRIM(RTRIM([UOM])) AS [UOM]
     , LTRIM(RTRIM([Form])) AS [Form]
     , LTRIM(RTRIM([Form Description])) AS [Form Description]
     , LTRIM(RTRIM([Color])) AS [Color]
     , LTRIM(RTRIM([Shape])) AS [Shape]
     , LTRIM(RTRIM([Brand/Generic (CGIC)])) AS [Brand/Generic (CGIC)]
     , LTRIM(RTRIM([TEE Rating])) AS [TEE Rating]
     , LTRIM(RTRIM([DEA Schedule Number])) AS [DEA Schedule Number]
     , LTRIM(RTRIM([NIFO])) AS [NIFO]
     , LTRIM(RTRIM([Sell Price])) AS [Sell Price]
	 , LTRIM(RTRIM([Sell Price per Unit])) AS [Sell Price per Unit]
     , LTRIM(RTRIM([Generic Name])) AS [Generic Name]
     , LTRIM(RTRIM([Brand Name])) AS [Brand Name]
     , LTRIM(RTRIM([Status])) AS [Status]
	 , LTRIM(RTRIM([Formulary Name])) AS [Formulary Name]
	 , LTRIM(RTRIM([END_DTE])) AS [END_DTE]
	 --, CONVERT(DATE, CONVERT(VARCHAR (500),LTRIM(RTRIM([END_DTE])),110)) AS [END_DTE] 
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0'
               ,'Excel 12.0 Xml;Database=C:\Cardinal\FormularyFiles\AAP-CustomerFormularyReport.xlsx;HDR=YES'
               ,'select * FROM [Load$a6:aa]'
               )
END

GO
