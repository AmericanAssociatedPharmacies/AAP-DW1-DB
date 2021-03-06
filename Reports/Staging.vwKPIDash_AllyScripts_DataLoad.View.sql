USE [Reports]
GO
/****** Object:  View [Staging].[vwKPIDash_AllyScripts_DataLoad]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwKPIDash_AllyScripts_DataLoad]

AS


SELECT CONVERT(VARCHAR(255), Pharmacy) AS [AccountName]
, CONVERT(CHAR(2), State) AS [State]
, CONVERT(VARCHAR(255), AAPNumber) AS [AAPAccountNumber]
, CONVERT(VARCHAR(255), APINumber) AS [APIAccountNumber]
, CONVERT(DATETIME, [Date]) AS [Date]
, CONVERT(INT, RXReceived) AS [RxReceived]
, CONVERT(INT, RXFilled) AS [RxFilled]
, CONVERT(INT, Transferred) AS [RxTransferred]
FROM ODSIntake.[Staging].[KPI_AllyScripts]
GO
