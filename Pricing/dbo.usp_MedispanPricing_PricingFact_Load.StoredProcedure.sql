USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_MedispanPricing_PricingFact_Load]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_MedispanPricing_PricingFact_Load]

AS

SET NOCOUNT ON;

BEGIN

	UPDATE [dbo].[PriceFact]
	SET [AWP] = mp.AWP
	, [DirectPrice] = mp.[DirectPrice]
	, [CMSFUL] = mp.[CMSFUL]
	, [WAC] = mp.WAC
	, [AAWP] = mp.[AAWP]
	, [GEAP] = mp.[GEAP]
	FROM [dbo].[PriceFact] AS x
	INNER JOIN [Staging].[MedispanPricing] AS mp ON x.DateKey = mp.Datekey
													AND x.DrugKey = mp.DrugKey


END
GO
