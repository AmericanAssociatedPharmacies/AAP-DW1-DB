USE [CAHODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_FormularyFile_DataLoad]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_CAH_FormularyFile_DataLoad]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [dbo].[CAH_FormularyFile](FileRowID, DateKey, CAHFileType, CIN, Description, Size, AAPSell, Supplier, BrandName, Form, NDCUPC, UOM, PricePerUnit, GPIID, GCN, GCNSEQ, Color, FileProcessed, CorrectedNDCUPC, IsBackupSource, IsTenSource, IsSourceWeekly, IsTopGenerics)--DPNum,
	SELECT FileRowID, DateKey, CAHFileType, CIN, Description, Size, AAPSell
	, Supplier, BrandName, Form, NDCUPC, UOM, PricePerUnit, GPIID, GCN, GCNSEQ, Color --DPNum, 
	, FileProcessed, CorrectedNDCUPC, IsBackupSource, IsTenSource, IsSourceWeekly, IsTopGenerics
	FROM [Staging].[vw_CAH_FormularyFile] AS a
	WHERE NOT EXISTS(SELECT 1
						FROM [dbo].[CAH_FormularyFile] AS b
						WHERE a.DateKey = b.DateKey
						AND a.[CorrectedNDCUPC] = b.CorrectedNDCUPC
						)

END

GO
