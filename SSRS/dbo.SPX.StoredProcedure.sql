USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[SPX]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SPX]

AS

SET NOCOUNT ON;


BEGIN

DECLARE @StartDateKey INT
, @EndDateKey INT

SET @StartDateKey = cast(CONVERT(varchar(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0),112) as INT)
SET @EndDateKey = cast(CONVERT(varchar(20),DATEADD(dd, -1, DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, 0)),112) as INT)


        
		SELECT dt.PMID
		, dt.AccountName
		, dt.NDC
		, dt.Sales
		, dt.[Month]
		FROM(SELECT DISTINCT pd.PMID
			, TRY_CONVERT(VARCHAR(65),pd.PharmacyName) AS AccountName
			, TRY_CONVERT(VARCHAR(15),dd.NDC) AS NDC
			, TRY_CONVERT(FLOAT,SUM(cah.[CAHExtendedSales])) AS Sales
			, MONTH(d.TheDate) AS Month
			FROM(SELECT DISTINCT MAX(DrugKey) AS DrugKey, NDC 
						FROM SalesDDS.dbo.DrugDim
						WHERE NDC IN('15584010101', '61958250101', '61958200201', '59676057101', '00006022761', '00074679922', '61958210101', '59676056201', '59676056630', '49702022813', '49702023113', '61958070101', '61958060101', '49702024213', '49702022418')
						GROUP BY NDC
						) AS dd
			INNER JOIN SalesDDS.dbo.SalesFact_CAH AS cah ON dd.DrugKey = cah.DrugKey
			INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON pd.PharmacyKey = cah.PharmacyKey
			INNER JOIN SalesDDS.dbo.DateDim AS d ON cah.Datekey = d.DateKey
			WHERE cah.DateKey BETWEEN @StartDateKey AND @EndDateKey
			AND pd.PMID > 0
			GROUP BY pd.PMID
			, pd.PharmacyName 
			, dd.NDC
			, MONTH(d.TheDate)
			) AS dt
		ORDER BY dt.Sales DESC
		
		
		
		
		--SELECT a.PMID
  --      , b.AccountName
  --      , a.NDC
  --      , SUM(a.EXT_COST) AS Sales
  --      , MONTH(a.INV_DATE) AS Month
  --      FROM SSRS.dbo.CAHSales AS a
  --           JOIN PharmacyMaster.dbo.PM_Pharmacy AS b ON a.PMID = b.PMID
  --      WHERE a.NDC IN('15584010101', '61958250101', '61958200201', '59676057101', '00006022761', '00074679922', '61958210101', '59676056201', '59676056630', '49702022813', '49702023113', '61958070101', '61958060101', '49702024213', '49702022418')
  --      AND a.DateKey >= @StartDateKey
		--AND a.DateKey <= @EndDateKey
		----AND a.INV_DATE >= DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)
  --      --AND a.INV_DATE <= DATEADD(dd, -1, DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, 0))
  --      AND a.PMID IS NOT NULL
  --      GROUP BY a.PMID
  --             , b.AccountName
  --             , a.NDC
  --             , MONTH(a.INV_DATE)
  --      ORDER BY SUM(a.EXT_COST) DESC;
END


GO
