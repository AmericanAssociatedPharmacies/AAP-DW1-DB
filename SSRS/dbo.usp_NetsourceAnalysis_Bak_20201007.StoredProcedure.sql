USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_NetsourceAnalysis_Bak_20201007]    Script Date: 12/22/2020 8:05:41 AM ******/
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
CREATE PROCEDURE [dbo].[usp_NetsourceAnalysis_Bak_20201007]

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

SELECT @PMID = @PMID
FROM SalesDDS.dbo.PharmacyDim 
WHERE PMID = @PMID

SELECT
 --p.PMID
 d.NDC
,d.DrugName
,sum(s.CAHInvoiceQuantity) CAHInvQty
,f.cardinalinvoiceprice as CAHCatalogPrice
,(s.CAHUnitAmount) as CAHInvUnitPrice
,sum(s.CAHExtendedSales) as CAHInvExtSalesAmt
,f.cardinalinvoiceprice - ABS(CAHUnitAmount) As PriceDiff
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
and s.datekey between @StartdateKey and @EnddateKey
and p.PMID = @PMID
and CAHUnitAmount <> 0
and CardinalInvoicePrice > ABS(CAHUnitAmount)
and ((f.cardinalinvoiceprice - ABS(CAHUnitAmount))/CAHUnitAmount) >= .10
group by p.pmid
,d.ndc
,d.drugname
,f.cardinalinvoiceprice
,(s.CAHUnitAmount)
,e.ItemType
,c.new_cah_cog
,c.new_cahgenericrebate
,e.Brand
HAVING sum(s.CAHInvoiceQuantity) <> 0
order by 7 asc

--SELECT
-- p.PMID
--,d.NDC
--,d.DrugName
--,sum(s.CAHInvoiceQuantity) CAHInvQty
--,f.cardinalinvoiceprice as CAHCatalogPrice
--,s.CAHUnitAmount as CAHInvUnitPrice
--,sum(s.CAHExtendedSales) as CAHInvExtSalesAmt
--,f.cardinalinvoiceprice - CAHUnitAmount As PriceDiff
----,CASE 
----WHEN e.ItemType = 'RX' and e.Brand = 'B' THEN convert(decimal(18,2),(CAHUnitAmount) * convert(decimal(18,2),(c.new_cah_cog) *.01)) 
----WHEN e.ItemType = 'RX' and e.Brand = 'N' THEN convert(decimal(18,2),(s.CAHUnitAmount) * convert(decimal(18,2),(c.new_cahgenericrebate) *.01))
----ELSE 0
----END AS RebateAmt
----,CASE 
----WHEN e.ItemType = 'RX' and e.Brand = 'B' THEN convert(decimal(18,2),(c.new_cah_cog) *.01)
----WHEN e.ItemType = 'RX' and e.Brand = 'N' THEN convert(decimal(18,2),(c.new_cahgenericrebate) *.01)
----ELSE 0
----END AS RebatePercentage
--FROM salesdds.dbo.SalesFact_CAH S
--inner join salesdds.dbo.EventDimCAH E
--on s.CAHEventKey = E.EventKey
--AND s.CAHEventDateKey = e.DateKey
--inner join SalesDDS.dbo.PharmacyDim P
--on s.PharmacyKey = p.PharmacyKey
--inner join DynamicsODS..CRM_AccountEntity_CAH c
--on p.AccountID = c.accountid
--inner join salesdds.dbo.DrugDim D
--on s.DrugKey = d.DrugKey
--left outer join Pricing.dbo.PriceFact F
--on s.DateKey = f.DateKey
----and d.DrugKey= f.DrugKey
--where p.PMID = 109228
--and itemtype = 'RX'
--and Brand <> 'B'
--and s.datekey between @StartdateKey and @EnddateKey
--and CardinalInvoicePrice > ABS(CAHUnitAmount)
--and CAHInvoiceQuantity > 0
--group by p.pmid
--,d.ndc
--,d.drugname
--,f.cardinalinvoiceprice
--,s.CAHUnitAmount
--,e.ItemType
--,c.new_cah_cog 
--,c.new_cahgenericrebate
--,e.Brand
--order by 1, 2, 3, 4, 5

END


GO
