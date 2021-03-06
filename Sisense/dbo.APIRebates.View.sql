USE [Sisense]
GO
/****** Object:  View [dbo].[APIRebates]    Script Date: 12/22/2020 8:00:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[APIRebates]

AS

SELECT [Date]
, [PMID]
, [API Generic Sales]
, [API Brand Sales]
, [API OTC Sales]
, [API Total Whse Sales]
, [API Whse Gross Rebate]
, [Adjust for Promotions]
, [Adjust for Returns]
, [Net Rebate to Store]
, [Accelerated Pay Discount]
, [AreteRebateFee]
, [APIInstantRebate]
FROM [PharmacyMaster].dbo.[PM_Rebates_APIMonthly_New]

GO
