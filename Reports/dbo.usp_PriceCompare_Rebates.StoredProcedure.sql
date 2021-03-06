USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceCompare_Rebates]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_PriceCompare_Rebates]

	@APIItemList VARCHAR(1000)

AS


SET NOCOUNT ON;

BEGIN 

	SELECT CONVERT(MONEY, SUM(pf.APIRebate * dt.Qty)) AS Rebates
	FROM(SELECT ca.APIItemNumber, ca.Qty
		FROM [dbo].[DelimitedSplit8K](@APIItemList, ',')
		CROSS APPLY(SELECT LEFT(Item, NULLIF(CHARINDEX(':', Item) - 1, -1)) AS APIItemNumber
					, RIGHT(Item, ISNULL(NULLIF(CHARINDEX(':', REVERSE(Item)) - 1, -1), LEN(Item))) AS Qty
						) AS ca
			) AS dt
	INNER JOIN Pricing.dbo.vw_CompetitorDrugDim_PriceComparison AS cd ON dt.APIItemNumber = cd.API_ItemNumber
	INNER JOIN Pricing.dbo.vw_PriceFact_PriceComparison AS pf ON pf.CompetitorDrugKey = cd.CompetitorDrugKey
	CROSS APPLY(SELECT MAX(DateKey) AS DateKey
				FROM Pricing.dbo.vw_CompetitorDrugDim_PriceComparison
						) AS ca
	WHERE ca.DateKey = cd.DateKey
	AND ca.DateKey = pf.DateKey

END



GO
