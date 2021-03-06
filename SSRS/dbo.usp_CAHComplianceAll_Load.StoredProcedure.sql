USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAHComplianceAll_Load]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CAHComplianceAll_Load]

AS

SET NOCOUNT ON;

BEGIN

INSERT INTO SalesDDS.[dbo].[CAHComplianceAll](PMID, GPI, DateKey, DrugDesc, PurchaseQty, PricePerUnit, PurchaseAtInvoicePrice, InvoicePerDose)

 SELECT PMID
 ,z.GPI
, DateKey
, z.Description
, z.PricePerUnit
, SUM(z.[Dispense Qty]) AS [Dispense Qty]
, SUM(z.[Dispense @ IP]) AS [Dispense @ IP]
, AVG(InvoicePerDose) AS InvoicePerDose  -- Added by RSE
                      
               FROM
               (
                   SELECT PMID,
                          c.GPI, 
						  dd.DateKey,
						--[InvoiceDate], 
                          Description, 
						  ISNULL(cc.CAHPricePerUnit,0.00) AS PricePerUnit,
                          SUM(Doses) AS [Dispense Qty], 
                          CAST(SUM(Doses) * (InvoicePerDose2) AS DECIMAL(18, 2)) AS [Dispense @ IP],
                          AVG(InvoicePerDose2) AS InvoicePerDose -- Added by RSE
                   FROM SalesDDS.[dbo].[CAHComplianceReport] AS c
				   INNER JOIN SalesDDS.dbo.DateDim AS dd ON c.InvoiceDate = dd.TheDate
				   LEFT OUTER JOIN(SELECT dd.GPI							
									, MIN(CONVERT(DECIMAL(10,4), c.InvoicePrice/(dd.PackageSize*dd.PackageQuantity))) AS CAHPricePerUnit
									FROM CAHODS.dbo.CardinalComplete AS c
									INNER JOIN DrugMaster.dbo.DrugDim AS dd ON c.NDC = dd.NDC
									GROUP BY dd.GPI
									) AS cc ON c.GPI = cc.GPI
							
                  WHERE InvoiceDate BETWEEN '20190618' AND '20200618'
                                    --AND IsGeneric = @BG
                   GROUP BY PMID,
                            c.GPI, 
							DateKey,
							 cc.CAHPricePerUnit , 
                            Description, 
                            InvoicePerDose2
               ) AS z
               GROUP BY z.PMID, 
                         z.GPI, 
						 DateKey,
						 z.PricePerUnit , 
                        z.Description;



END
GO
