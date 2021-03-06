USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Arete_FormularyPricing]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROC [dbo].[usp_Arete_FormularyPricing]

AS

SET NOCOUNT ON;

TRUNCATE TABLE Pricing.dbo.Arete_FormularyPricingRecordCountLog

DECLARE @CurrentFridayDateKey INT
DECLARE @TotalRecords Int

SET @CurrentFridayDateKey = CAST(CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 0),112) as INT)

SELECT dd.NDC
	 , dd.Description
	 , dd.UnitofMeasure AS Unit
	 , CONVERT(INT,dd.PackageSize) AS Size
	 , NULL AS [Contract]
	 , dd.AWPPackagePrice AS Price
	 --, dd.AWPPerDose AS PricePerDose
	 , CONVERT(MONEY,CASE WHEN CONVERT(INT,dd.PackageSize) = 0 THEN NULL 
	   ELSE pf.APICustomerInvoicePrice/(CONVERT(INT,dd.PackageSize) * dd.PackageQuantity) 
	   END)  AS APINewPricePerUnit
	 , cd.API_ItemNumber
	 , NULL AS DateOfLastPriceChange
	 , dd.UnitofMeasure
	 , dd.Strength + ' ' + dd.StrengthUnitMeasure AS BillableSize
	 , dd.Manufacturer AS Supplier
	 , CASE
	        WHEN IsRX = 1 THEN dd.DrugName 
	        ELSE NULL
	        END AS BrandName
	 , dd.Form
	 , NULL AS Color
	 , NULL AS DP#
	 , dd.GPI
FROM Pricing.dbo.PriceFact AS pf
INNER JOIN Pricing.dbo.DrugDim AS dd on pf.DrugKey = dd.DrugKey
INNER JOIN Pricing.dbo.CompetitorDrugDim AS cd ON pf.CompetitorDrugKey= cd.CompetitorDrugKey
WHERE pf.DateKey = @CurrentFridayDateKey
AND cd.API_ItemNumber IS NOT NULL


SET @TotalRecords = @@ROWCOUNT
INSERT INTO Pricing.dbo.Arete_FormularyPricingRecordCountLog(TotalCount)
VALUES (@TotalRecords)

GO
