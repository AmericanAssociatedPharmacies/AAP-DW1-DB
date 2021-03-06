USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIComplianceAll_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APIComplianceAll_Load]

AS

SET NOCOUNT ON;

BEGIN


INSERT INTO SalesDDS.[dbo].[APIComplianceAll](PMID, GPI, DateKey, DrugDesc, PurchaseQty, PurchaseAtInvoicePrice, InvoicePerDose, PricePerUnit)

 SELECT PMID
 ,z.GPI
, DateKey
, z.Description
, SUM(z.[PurchaseQty]) AS PurchaseQty
, SUM(z.PurchaseAtInvoicePrice) AS PurchaseAtInvoicePrice
, AVG(InvoicePerDose) AS InvoicePerDose  -- Added by RSE
, PricePerUnit
               FROM
               (
                   SELECT PMID,
						dd.DateKey, 
                          a.GPI, 
                          Description, 
						  g.APIPricePerUnit AS PricePerUnit,
                          SUM(Doses) AS [PurchaseQty], 
                          CAST(SUM(Doses) * (InvoicePerDose) AS DECIMAL(18, 2)) AS PurchaseAtInvoicePrice,
						  AVG(InvoicePerDose) AS InvoicePerDose -- Added by RSE, 

                   FROM SalesDDS.[dbo].[APIComplianceReport] AS a
				   INNER JOIN dbo.DateDim AS dd ON a.InvoiceDate = dd.TheDate
				   INNER JOIN(SELECT dd.GPI
							, MIN(a.APIPricePerUnit) AS APIPricePerUnit
							FROM ODSIntake.[dbo].[vwAPIPricing] AS a
							INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
							INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
							WHERE (ac.Tier1Item = 1 OR ac.Tier2Item = 1	)
							GROUP BY dd.GPI 
							) AS g ON a.GPI = g.GPI
                   --WHERE InvoiceDate BETWEEN @StartDate AND @EndDate
                   --AND IsGeneric = @BG
                   GROUP BY PMID,
							a.GPI, 
							DateKey,					
                            Description, 
                            InvoicePerDose,
							g.APIPricePerUnit
               ) AS z
               GROUP BY PMID,
			   DateKey,
						z.GPI, 
                        z.Description,
						z.PricePerUnit

END
GO
