USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwABC]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwABC]

AS


SELECT dt.DateKey
, dt.ABCItemNum
, dt.NDC
, ca.ABC_AWP
, ca.ABCInvoicePrice
FROM(SELECT RowID
		, DateKey
		, CONVERT(VARCHAR(500), SUBSTRING([C1],1,6)) AS ABCItemNum
		, CONVERT(VARCHAR(500), SUBSTRING(C1, 68, 11)) AS NDC
		, CONVERT(VARCHAR(500), SUBSTRING(C1, 194, 7)) AS ABC_AWP
		, CONVERT(VARCHAR(500), SUBSTRING(C1, 47, 7)) AS ABCInvoicePrice
		FROM [Staging].[ABC_Raw]
       ) AS dt
CROSS APPLY(SELECT RowID 
				, CONVERT(VARCHAR(20), LEFT(ABC_AWP, 5) + '.' + RIGHT(ABC_AWP, 2)) AS ABC_AWP
			   , CONVERT(VARCHAR(20), LEFT(ABCInvoicePrice, 5) + '.' + RIGHT(ABCInvoicePrice, 2)) AS ABCInvoicePrice
			   FROM [Staging].[ABC_Raw] AS ar
			   WHERE dt.RowID = ar.RowID
					) AS ca
WHERE dt.RowID = ca.RowID
GO
