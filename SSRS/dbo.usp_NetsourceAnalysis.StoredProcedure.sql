USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_NetsourceAnalysis]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Report detail design------------------------------------------------------------
--items they are purchasing (ndc, drugname)
--AAP Contract price (CAH Catalog Price) Pricefact
--Net Source price they negotiated (CAH Unit Amount from Sales Fact)
--Price diff between contract and netsource ( CAH Catalog Price - CAH Unit Amount)
--Quantity purchased each month (quantity from sales fact table)
--Cardinal rebate %
-----------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[usp_NetsourceAnalysis]

@PMID INT, @StartDate DATETIME, @EndDate DATETIME

AS 
 
BEGIN

DECLARE @StartdateKey int
       ,@EnddateKey int
	  

SELECT @StartdateKey = DateKey
FROM SalesDDS.dbo.DateDim
WHERE TheDate = @StartDate


SELECT @EnddateKey = DateKey
FROM SalesDDS.dbo.DateDim
WHERE TheDate = @EndDate


SELECT PMID, NDC, CAHItemNumber, DrugName, 
CAHInvQty, CAHCatalogPrice, CAHInvUnitPrice,
CAHCatalogExtSalesAmt, CAHInvExtSalesAmt,
CAHCatalogPrice - CAHInvUnitPrice as PriceDiff,
((CAHCatalogPrice - CAHInvUnitPrice)/ CAHCatalogPrice) as PriceDiffPct

FROM (
SELECT
 p.PMID
,d.NDC
,e.ItemNumber as CAHItemNumber
,d.Description as DrugName
,sum(s.CAHInvoiceQuantity) CAHInvQty
,f.cardinalinvoiceprice as CAHCatalogPrice
,(s.CAHUnitAmount) as CAHInvUnitPrice
,sum(f.cardinalinvoiceprice * s.CAHInvoiceQuantity) as CAHCatalogExtSalesAmt
,sum(s.CAHExtendedSales) as CAHInvExtSalesAmt
FROM salesdds.dbo.SalesFact_CAH S
inner join salesdds.dbo.EventDimCAH E
on s.CAHEventKey = E.EventKey
AND s.CAHEventDateKey = e.DateKey
inner join SalesDDS.dbo.PharmacyDim P
on s.PharmacyKey = p.PharmacyKey
inner join DynamicsODS..CRM_AccountEntity_CAH c
on p.AccountID = c.accountid
inner join salesdds.dbo.DrugDim D
on s.DrugKey = d.DrugKey
inner join Pricing.dbo.DateDim DD
on s.DateKey = dd.DateKey
left outer join ( SELECT CCYYMM as datekey, Drugkey, min(CardinalInvoicePrice) as CardinalInvoicePrice
					FROM Pricing.dbo.PriceFact PF
					INNER JOIN Pricing.dbo.DateDim DD
					ON PF.DateKey = dd.DAtekey
					GROUP BY CCYYMM, DrugKey
					) F
on dd.CCYYMM = f.DateKey
and d.DrugKey= f.DrugKey
where Brand <> 'B'
And ItemType='RX'
and s.datekey between @StartdateKey and @EnddateKey
and p.PMID = @PMID
and CAHUnitAmount <> 0
and CardinalInvoicePrice > ABS(CAHUnitAmount)
and ((f.cardinalinvoiceprice - ABS(CAHUnitAmount))/CAHUnitAmount) >= .10
group by 
 p.pmid
,d.ndc
,e.ItemNumber
--,d.drugname
,d.Description
,f.cardinalinvoiceprice
,(s.CAHUnitAmount)
,e.ItemType
,c.new_cah_cog
,c.new_cahgenericrebate
,e.Brand
HAVING sum(s.CAHInvoiceQuantity) <> 0
) AA

END


GO
