USE [Pricing]
GO
/****** Object:  View [Staging].[vwABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [Staging].[vwABC]


AS


SELECT dt.DateKey
, dt.ABCItemNum
, dt.NDC
, dt.ABC_AWP
, dt.ABCInvoicePrice
FROM(SELECT CASE
		WHEN DATEPART(dw, GETDATE()) = 2 THEN DateKey
		ELSE CAST(CONVERT(varchar(20), GETDATE(), 112) as INT)
		END AS DateKey
	, CONVERT(VARCHAR(50), ABCItemNum) AS ABCItemNum
	, CONVERT(VARCHAR(11), NDC) AS NDC
	, CONVERT(MONEY, ABC_AWP) AS ABC_AWP
	, CONVERT(MONEY, ABCInvoicePrice) AS ABCInvoicePrice
	FROM ODSIntake.Staging.ABC
	) AS dt
GO
