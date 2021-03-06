USE [ODSIntake]
GO
/****** Object:  View [Archive].[vwCardinalCatalog]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [Archive].[vwCardinalCatalog]


AS


SELECT ROW_NUMBER() OVER(PARTITION BY dt.NDC, dt.DateKey ORDER BY(SELECT NULL)) AS RN
, dt.NDC
, dt.CardinalItemNumber
, dt.CardinalInvoicePrice
, CASE 
	WHEN dt.Size = 0.00 THEN NULL
	ELSE dt.Size
	END AS Size
, dt.DateKey
, dt.ContractType
FROM(SELECT CONVERT(VARCHAR(11), NDC) AS NDC
		, CONVERT(VARCHAR(25), [CIN]) AS CardinalItemNumber
		, CONVERT(MONEY, [Cost]) AS CardinalInvoicePrice
		, CONVERT(DECIMAL(10,3), Size) AS Size
		, CONVERT(INT, REPLACE(RIGHT([FileDir], 12), '.txt', '')) AS DateKey
		, CONVERT(VARCHAR(500), CASE
			WHEN Col9 LIKE '%[a-zA-Z0-9]%' THEN LTRIM(RTRIM(REPLACE(REPLACE([Col9], '  ' , ' '), '   ', ' ')))
			WHEN Col9 NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
			END
			)
			AS ContractType
		FROM ODSIntake.Archive.CardinalCatalog
	) AS dt








GO
