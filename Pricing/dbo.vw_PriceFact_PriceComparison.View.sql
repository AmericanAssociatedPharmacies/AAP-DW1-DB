USE [Pricing]
GO
/****** Object:  View [dbo].[vw_PriceFact_PriceComparison]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_PriceFact_PriceComparison]

AS

SELECT [DateKey], [DrugKey], [CompetitorDrugKey], [APIRebate]
FROM dbo.PriceFact
GO
