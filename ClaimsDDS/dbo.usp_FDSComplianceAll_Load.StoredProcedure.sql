USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDSComplianceAll_Load]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FDSComplianceAll_Load]


 AS

 SET NOCOUNT ON;

 BEGIN
 
 
 
 INSERT INTO [dbo].[FDSComplianceAll](PMID, DateKey, GPI, DrugDesc, [DispensedAtInvoicePrice], [DispenseQty]) 
 SELECT PMID,
  DateKey,
z.GPI, 
z.Description, 
[DispensedAtInvoicePrice],	
SUM(z.[Dispense Qty]) AS [DispenseQty] 
     
               FROM
               (
                   SELECT f.PMID, 
							dd.DateKey,
                          f.GPI, 
                          Description, 
                          SUM(QuantityDispensed) AS [Dispense Qty],
                          CAST(SUM(QuantityDispensed) * ISNULL((ISNULL(a.InvoicePerDose,c.InvoicePerDose)), g.PricePerUnit) AS DECIMAL(18, 2)) AS [DispensedAtInvoicePrice]						
                   FROM ClaimsDDS.[dbo].[FDSComplianceReport] AS f
				   INNER JOIN dbo.DateDim AS dd ON f.TransactionDate = dd.TheDate
				   LEFT OUTER JOIN SalesDDS.dbo.APIComplianceAll AS a ON f.DateKey = a.DateKey
																		AND f.PMID = a.PMID		
																		AND f.GPI = a.GPI
					LEFT OUTER JOIN SalesDDS.dbo.CAHComplianceAll AS c ON f.DateKey = c.DateKey
																		AND f.PMID = c.PMID		
																		AND f.GPI = c.GPI
					LEFT OUTER JOIN(SELECT DISTINCT ISNULL(a.GPI,cah.GPI) AS GPI
										, ISNULL(a.APIPricePerUnit, cah.CAHPricePerUnit) AS PricePerUnit
										FROM DrugMaster.dbo.DrugDim AS dt	
										LEFT OUTER JOIN(SELECT dd.GPI
															, MIN(a.APIPricePerUnit) AS APIPricePerUnit
															FROM ODSIntake.[dbo].[vwAPIPricing] AS a
															INNER JOIN DrugMaster.dbo.DrugDim AS dd ON a.NDC = dd.NDC
															INNER JOIN DrugMaster.dbo.APICatalog AS ac ON ac.NDC = dd.NDC
															WHERE (ac.Tier1Item = 1 OR ac.Tier2Item = 0)
															GROUP BY dd.GPI
														) AS a ON a.GPI = dt.GPI
										LEFT OUTER JOIN(SELECT dd.GPI									
														, MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
														FROM CAHODS.dbo.CardinalComplete AS c
														INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC				
														GROUP BY dd.GPI
														) AS cah ON dt.GPI = cah.GPI
										WHERE a.GPI IS NOT NULL
										OR cah.GPI IS NOT NULL
									) AS g ON g.GPI = f.GPI		
                   WHERE IsGeneric = 1
					 AND Is340BClaim = 0					
                   GROUP BY f.PMID,
							dd.DateKey,
							f.GPI, 
                            Description, a.InvoicePerDose,c.InvoicePerDose, g.PricePerUnit
                           
               ) AS z
               GROUP BY PMID,
					DateKey,
                      z.GPI, 
                      z.Description,
					  [DispensedAtInvoicePrice]


END
			
GO
