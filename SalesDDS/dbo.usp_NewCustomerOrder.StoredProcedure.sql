USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_NewCustomerOrder]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_NewCustomerOrder] 

	@P1 INT
AS

SET NOCOUNT ON;
         
BEGIN

    DECLARE @d1 DATETIME
	, @d2 DATETIME
	, @StartDateKey INT
	, @EndDateKey INT
            
	SET @d1 = GETDATE();
    SET @d2 = DATEADD(yy, DATEDIFF(yy, 0, @d1), 0);
			 

	SET @StartDateKey = cast(CONVERT(varchar(20),@d2,112) as INT)
	SET @EndDateKey = cast(CONVERT(varchar(20),@d1,112) as INT)

	--SELECT @StartDateKey, @EndDateKey

SELECT d1.APIAccountNo
         , d1.AccountName
	--, pd.Territory
	, NULL AS TMName
	--, CONCAT(pm.TMFirstName, ' ', pm.TMLastName) AS TMName
	, d1.TotalSalesYTD
	 , d1.QtyYTD
	 ,d1.Type
	, d1.MonthOfYear
	, d1.DateOpened
       , d1.BizAge
FROM(SELECT pm.APIAccountNo
         , pm.AccountName
	--, pd.Territory
	, NULL AS TMName
	--, CONCAT(pm.TMFirstName, ' ', pm.TMLastName) AS TMName
	, FORMAT(SUM(sf.APIExtendedAmount), 'C') AS TotalSalesYTD
	 , SUM(sf.APIInvoiceQuantity) AS QtyYTD
	 , CASE
		WHEN rx.DrugType LIKE '%BRAND%' AND rx.IsOTC = 0  THEN 'Brand'
		WHEN rx.DrugType LIKE '%GENERIC%' THEN 'Generic'
		WHEN rx.IsOTC = 1 THEN 'OTC'
		END AS Type
	, dd.MonthOfYear
	, pm.DateOpened
       , SalesDDS.dbo.fn_APIBusinessDays(pm.DateOpened, @d1) AS BizAge
	FROM dbo.DateDim AS dd
	INNER JOIN dbo.SalesFact_API AS sf ON dd.DateKey = sf.DateKey
	INNER JOIN dbo.DrugDim AS rx ON sf.DrugKey = rx.DrugKey
	INNER JOIN dbo.EventDimAPI AS a ON sf.APIEventKey = a.EventKey
										AND sf.[APIEventDateKey] = a.DateKey
	INNER JOIN PharmacyMaster.dbo.v_PM_AllWithAffiliates AS pm ON pm.PMID = a.PMID
	--INNER JOIN dbo.PharmacyDim AS pd ON sf.PharmacyKey = pd.PharmacyKey
	WHERE sf.DateKey >= @StartDateKey
	AND sf.DateKey < @EndDateKey
	GROUP BY pm.APIAccountNo
         , pm.AccountName
	--, pd.Territory
	, rx.DrugType
	, rx.IsOTC
	, dd.MonthOfYear
	, pm.DateOpened
) AS d1 
WHERE d1.BizAge <= @P1
ORDER BY d1.APIAccountNo ASC

END
GO
