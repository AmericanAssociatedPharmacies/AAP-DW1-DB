USE [Pricing]
GO
/****** Object:  View [dbo].[vw_CompetitorDrugDim_PriceComparison]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_CompetitorDrugDim_PriceComparison]

AS

SELECT CompetitorDrugKey, DateKey ,API_ItemNumber
FROM dbo.CompetitorDrugDim
GO
