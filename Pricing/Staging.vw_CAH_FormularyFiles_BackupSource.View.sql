USE [Pricing]
GO
/****** Object:  View [Staging].[vw_CAH_FormularyFiles_BackupSource]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [Staging].[vw_CAH_FormularyFiles_BackupSource]

AS

SELECT ca.Datekey
, dt.CardinalItemNumber
, dt.Size
, dt.CardinalInvoicePrice
, dt.NDC
, ca.PricePerUnit
, dt.IsFormularyFile
, dt.ContractType
FROM(SELECT CONVERT(VARCHAR(25), CIN) AS CardinalItemNumber 
	, CONVERT(DECIMAL(10,3), LEFT([Accunet Size], NULLIF(CHARINDEX(' ', [Accunet Size]) - 1, -1))) AS Size
	, CONVERT(MONEY, [Sell Price]) AS CardinalInvoicePrice
	, CONVERT(VARCHAR(11), [CorrectedNDC]) AS NDC
	, CONVERT(VARCHAR(500), 'AAP SOURCE BACKUP') AS ContractType
	, CONVERT(BIT, 1) AS IsFormularyFile
	FROM [ODSIntake].[Staging].[CAH_FormularyFile]
	WHERE CAHFileType = 'IsBackupSource'
	) AS dt
CROSS APPLY(SELECT CONVERT(MONEY, dt.[CardinalInvoicePrice]/dt.Size) AS PricePerUnit
			, s.DateKey
			FROM(SELECT DISTINCT DateKey
					FROM Staging.CardinalCatalog			
						) AS s		
			) AS ca





GO
