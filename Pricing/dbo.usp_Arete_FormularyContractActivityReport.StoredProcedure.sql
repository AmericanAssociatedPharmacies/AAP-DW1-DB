USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Arete_FormularyContractActivityReport]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROC [dbo].[usp_Arete_FormularyContractActivityReport]

AS

SET NOCOUNT ON;

TRUNCATE TABLE Pricing.dbo.Arete_FormularyContractRecordCountLog

DECLARE @CurrentFridayDateKey INT
, @CurrentLastThursdayDateKey INT
, @CurrentThursdayDateKey INT
, @CurrentMondayDateKey INT
, @TotalRecords Int
 
SET @CurrentMondayDateKey = CAST(CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 0),112) as INT)
SET @CurrentLastThursdayDateKey = CAST(CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk,0,GETDATE()), -4),112) as INT)
SET @CurrentThursdayDateKey = CAST(CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 3),112) as INT)
SET @CurrentFridayDateKey = CAST(CONVERT(varchar(20),DATEADD(wk, DATEDIFF(wk,0,GETDATE()), 4),112) as INT)

 
 
SELECT dd.NDC AS ItemNbr
	 , CASE
	        WHEN pf.APICustomerInvoicePrice = dt.APICustomerInvoicePrice THEN NULL
	        WHEN dt.APICustomerInvoicePrice < pf.APICustomerInvoicePrice THEN 'PriceIncrease'
	     WHEN dt.APICustomerInvoicePrice > pf.APICustomerInvoicePrice THEN 'PriceDecrease'
	     ELSE NULL
	        END AS ChangeType
	 , dd.Description
	 , dd.Form
	 , dd.UnitofMeasure AS Unit
	 , dd.Manufacturer AS Supplier
	 , dd.NDC
	  , CONVERT(MONEY,CASE WHEN CONVERT(INT,dd.PackageSize) = 0 THEN NULL
	   ELSE dt.APICustomerInvoicePrice/(CONVERT(INT,dd.PackageSize) * dm.CSP)
	   END
	   ) AS APIOldPricePerUnit
	 , CONVERT(MONEY, CASE WHEN CONVERT(INT,dd.PackageSize) = 0 THEN NULL 
	   ELSE pf.APICustomerInvoicePrice/(CONVERT(INT,dd.PackageSize) * dm.CSP) 
	   END 
	   )AS APINewPricePerUnit
	 , dt.APICustomerInvoicePrice AS APIOldPrice
	 , pf.APICustomerInvoicePrice AS APINewPrice
	 --, dt.AWPPerDose AS OldPricePerDose
	 --, dd.AWPPerDose AS NewPricePerDose
	 --, CASE WHEN CONVERT(INT,dd.PackageSize) = 0 THEN NULL
	 --  ELSE dt.APICustomerInvoicePrice/(CONVERT(INT,dd.PackageSize) * dm.CSP)
	 --  END AS OldPricePerDose
	 --, CASE WHEN CONVERT(INT,dd.PackageSize) = 0 THEN NULL 
	 --  ELSE pf.APICustomerInvoicePrice/(CONVERT(INT,dd.PackageSize) * dm.CSP) 
	 --  END AS NewPricePerDose
	 , dm.WAC
	 , dm.DrugName AS BrandName
	 , NULL AS ReasonCode
	 , dm.WACEffDate AS EffectiveDate
	 , NULL AS Usage
	 , NULL AS GCN
	 , CONVERT(INT,dd.PackageSize) AS Size
FROM Pricing.dbo.PriceFact AS pf
INNER JOIN Pricing.dbo.DrugDim AS dd on pf.DrugKey = dd.DrugKey
INNER JOIN Pricing.dbo.CompetitorDrugDim AS cd ON pf.CompetitorDrugKey= cd.CompetitorDrugKey
INNER JOIN Medispan.dbo.DrugMaster AS dm ON dd.NDC = dm.NDC
LEFT OUTER JOIN(SELECT cd.API_ItemNumber
					, pf.APICustomerInvoicePrice
					, pf.WACPerDose
					, dd.AWPPerDose
                FROM Pricing.dbo.PriceFact AS pf 
				INNER JOIN Pricing.dbo.DrugDim AS dd on pf.DrugKey = dd.DrugKey
                INNER JOIN Pricing.dbo.CompetitorDrugDim AS cd ON pf.CompetitorDrugKey = cd.CompetitorDrugKey
                WHERE pf.DateKey = 20200416
				--@CurrentLastThursdayDateKey
                AND cd.API_ItemNumber IS NOT NULL
                       ) AS dt ON dt.API_ItemNumber = cd.API_ItemNumber

WHERE pf.DateKey = 20200423
--@CurrentThursdayDateKey
AND cd.API_ItemNumber IS NOT NULL


SET @TotalRecords = @@ROWCOUNT
INSERT INTO Pricing.dbo.Arete_FormularyContractRecordCountLog(TotalCount)
VALUES (@TotalRecords)


GO
