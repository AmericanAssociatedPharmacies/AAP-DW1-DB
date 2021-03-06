USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwFairShareProgram]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwFairShareProgram]

AS


SELECT CONVERT(VARCHAR(100), CustNum) AS CustNum
, CONVERT(VARCHAR(100), ProdNum) AS ProdNum
, CONVERT(NVARCHAR(255), ProdDesc) AS ProdDesc
, CONVERT(VARCHAR(15), NDC) AS NDC
, CONVERT(INT, [Count]) AS [Count]
, CONVERT(DATETIME, MinExpDate) AS ExpirationDate
, CONVERT(DECIMAL(18,2), Price) AS Price
, CONVERT(INT, MonthlyQty) AS MonthlyQty
, ISNULL(CONVERT(INT, RequestedQty), 0) AS RequestedQty
, CONVERT(DATETIME, StartDate) AS BeginDate
, CONVERT(DATETIME, EndDate) AS EndDate
, CONVERT(DATETIME, ShipWeekOf) AS ShipWeekOf
, DateKey
FROM [Staging].[FairShare]


GO
