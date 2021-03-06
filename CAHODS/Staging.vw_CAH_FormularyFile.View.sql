USE [CAHODS]
GO
/****** Object:  View [Staging].[vw_CAH_FormularyFile]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vw_CAH_FormularyFile]

AS

SELECT FileRowID
, DateKey
, CAHFileType
, CONVERT(VARCHAR(25), CIN) AS CIN
, CONVERT(VARCHAR(255), Description) AS [Description]
, CONVERT(VARCHAR(50), [Accunet Size]) AS Size
, CONVERT(MONEY, [Sell Price]) AS AAPSell
, CONVERT(VARCHAR(250), [Supplier Name]) AS [Supplier]
, CONVERT(VARCHAR(250), [Brand Name]) AS [BrandName]
, CONVERT(VARCHAR(250), Form) AS Form
, CONVERT(VARCHAR(11), NDC) AS [NDCUPC]
--, CONVERT(VARCHAR(250), DPNum) AS [DPNum]
, CONVERT(VARCHAR(250), UOM) AS UOM
, CONVERT(MONEY, ISNULL(NULLIF(RIGHT(ISNULL(LEFT([Sell Price per Unit], NULLIF(CHARINDEX('.', [Sell Price per Unit]) - 1, -1)), 6), 4), ''), 0)  + '.' + LEFT(RIGHT([Sell Price per Unit], ISNULL(NULLIF(CHARINDEX('.', REVERSE([Sell Price per Unit])) - 1, -1), LEN([Sell Price per Unit]))), 2)) AS [PricePerUnit]
, CONVERT(VARCHAR(250), [GPI Code]) AS GPIID
, CONVERT(VARCHAR(250), GCN) AS GCN
, CONVERT(VARCHAR(250), GCN_SEQ) AS GCNSEQ
, CONVERT(VARCHAR(250), Color) AS Color
, CONVERT(VARCHAR(1000), [Formulary Name]) AS [FileProcessed]
, CONVERT(VARCHAR(11), CorrectedNDC) AS [CorrectedNDCUPC]
, ISNULL(bp.IsBackupSource, 0) AS IsBackupSource
, ISNULL(ts.IsTenSource, 0) AS IsTenSource
, ISNULL(sw.IsSourceWeekly, 0) AS IsSourceWeekly
, ISNULL(tg.IsTopGenerics, 0) AS IsTopGenerics
FROM [ODSIntake].Staging.[CAH_FormularyFile] AS s
LEFT OUTER JOIN(SELECT RowID 
			,  CONVERT(BIT, 1) AS IsBackupSource
			FROM [ODSIntake].Staging.[CAH_FormularyFile]
			WHERE CAHFileType = 'IsBackupSource'
			) AS bp ON s.RowID = bp.RowID
LEFT OUTER JOIN(SELECT RowID 
			, CONVERT(BIT, 1) AS IsSourceWeekly
			FROM [ODSIntake].Staging.[CAH_FormularyFile]
			WHERE CAHFileType = 'IsSourceWeekly'
			) AS sw ON s.RowID = sw.RowID
LEFT OUTER JOIN(SELECT RowID 
			, CONVERT(BIT, 1) AS IsTenSource
			FROM [ODSIntake].Staging.[CAH_FormularyFile]
			WHERE CAHFileType = 'IsTenSource'
			) AS ts ON s.RowID = ts.RowID
LEFT OUTER JOIN(SELECT RowID 
			, CONVERT(BIT, 1) AS IsTopGenerics
			FROM [ODSIntake].Staging.[CAH_FormularyFile]
			WHERE CAHFileType = 'IsTopGenerics'
			) AS tg ON s.RowID = tg.RowID
GO
