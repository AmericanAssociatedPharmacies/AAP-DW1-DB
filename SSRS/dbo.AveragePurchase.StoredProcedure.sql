USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[AveragePurchase]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [dbo].[AveragePurchase] @StartDate DATETIME
                                      , @EndDate   DATETIME

AS

SET NOCOUNT ON;
BEGIN
	
	CREATE TABLE #T(RowID INT NOT NULL IDENTITY(1,1)
					, TM INT
					--, Date DATE INDEX idx_Col2 (PMID, Date)
					, PMID INT
					, AAPAccountNumber NVARCHAR(100)
					, AAPParent NVARCHAR(20)
					, GroupID NVARCHAR(100)
					, AAPEffectiveDate DATE
					, AAPQuitDate DATE
					, Description NVARCHAR(252)
					, Affiliate NVARCHAR(250)
					, PharmacyName NVARCHAR(255)
					, City NVARCHAR(255)
					, State NVARCHAR(255)
					, Contact NVARCHAR(100)
					, CAHBrandRx DECIMAL(18, 2)  DEFAULT 0.00
					, CAHExcludedRx DECIMAL(18, 2)  DEFAULT 0.00
					, CAHSourceGenericRx DECIMAL(18, 2)  DEFAULT 0.00
					, CAHNonContractGenericRx DECIMAL(18, 2)  DEFAULT 0.00
					, CAHNetSourceGenerics DECIMAL(18, 2)  DEFAULT 0.00
					, CAHOTC DECIMAL(18, 2)  DEFAULT 0.00
					, CAHSuppliesOther DECIMAL(18, 2)  DEFAULT 0.00
					, APIBrandSales MONEY NOT NULL DEFAULT 0.00 --API
					, APIGen MONEY NOT NULL DEFAULT 0.00 --API
					, APIOTC MONEY NOT NULL DEFAULT 0.00--API	
					, APIGenericSalesTier1 MONEY DEFAULT 0.00 --API
					, APIGenericSalesTier2 MONEY DEFAULT 0.00 --API
					
		         )
	--API data
	INSERT INTO #T(TM
					--, Date
					, PMID
					, AAPAccountNumber 
					, AAPParent 
					, GroupID 
					, AAPEffectiveDate 
					, AAPQuitDate 
					, Description
					--, Affiliate
					, PharmacyName 
					, City 
					, State 
					, Contact
					)
	SELECT DISTINCT CASE
		WHEN ISNUMERIC(u.new_territoriesname) = 1 THEN u.new_territoriesname
		ELSE NULL
		END AS TM
	--, CONVERT(DATE,a.Date) AS Date
	, CONVERT(INT,a.[PMID]) AS PMID
	, u.new_aap_account AS AAPAccountNumber
	, u.new_aapparent AS AAPParent
	, u.new_group AS GroupID
	, u.new_aap_effective_date AS AAPEffectiveDate
	, u.new_aapquit AS AAPQuitDate
	, s.statuscodename AS Description
	--, u.new_affiliatename AS Affiliate
	, s.name AS PharmacyName
	, ad.address1_city AS City
	, ad.address1_stateorprovince AS State
	, s.primarycontactidname AS Contact
	FROM PharmacyMaster.[dbo].[PM_Rebates_APIMonthly] AS a
	INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
	INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
	INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_Sys] s on ad.accountid = s.accountid
	WHERE a.[Date] >= @StartDate
	AND a.Date <= @EndDate

	--CAH data
	INSERT INTO #T(TM
					--, Date
					, PMID
					, AAPAccountNumber
					, AAPParent 
					, GroupID 
					, AAPEffectiveDate 
					, AAPQuitDate
					, Description
					--, Affiliate 
					, PharmacyName  
					, City 
					, State 
					, Contact
					)
	
	SELECT DISTINCT dt.TM
	--, dt.Date
	, dt.PMID
	, dt.AAPAccountNumber
	, dt.AAPParent
	, dt.GroupID
	, dt.AAPEffectiveDate
	, dt.AAPQuitDate
	, dt.Description
	--, dt.Affiliate
	, dt.PharmacyName
	, dt.City
	, dt.State
	, dt.Contact
	FROM(SELECT CASE	
			WHEN ISNUMERIC(u.new_territoriesname) = 1 THEN u.new_territoriesname
			ELSE NULL
			END AS TM
		, CONVERT(DATE,a.Date) AS Date
		, CONVERT(INT,a.[PMID]) AS PMID
		, u.new_aap_account AS AAPAccountNumber
		, u.new_aapparent AS AAPParent
		, u.new_group AS GroupID
		, u.new_aap_effective_date AS AAPEffectiveDate
		, u.new_aapquit AS AAPQuitDate
		, s.statuscodename AS Description
		, u.new_affiliatename AS Affiliate
		, s.name AS PharmacyName
		, ad.address1_city AS City
		, ad.address1_stateorprovince AS State
		, s.primarycontactidname AS Contact
		FROM PharmacyMaster.[dbo].[CH_ALLPVA_SALES] AS a
		--INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON a.pmid = p.pmid
		INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
		INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
		INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_Sys] s on ad.accountid = s.accountid
		WHERE a.Date >= @StartDate
		AND a.Date <= @Enddate 
		) AS dt
	WHERE NOT EXISTS(SELECT 1f
					FROM #T AS t
					WHERE dt.PMID = t.PMID
					--AND dt.Date = t.Date	
				   )

	UPDATE t
	SET APIBrandSales = dt.[API Brand Sales]
	, APIGen = dt.[API Generic Sales]
	, APIOTC = dt.[API OTC Sales]
	, APIGenericSalesTier1 = dt.APIGenericSalesTier1
	, APIGenericSalesTier2 = dt.APIGenericSalesTier2
	FROM #T AS t
	INNER JOIN(SELECT t.[PMID]
				, AVG(ISNULL(a.[API Brand Sales],0.00)) AS [API Brand Sales]
				, AVG(ISNULL(a.[API Generic Sales],0.00)) AS [API Generic Sales]
				, AVG(ISNULL(a.[API OTC Sales],0.00)) AS [API OTC Sales]
				, AVG(ISNULL(a.[APIGenericSalesTier1],0.00)) AS APIGenericSalesTier1
				, AVG(ISNULL(a.[APIGenericSalesTier2],0.00)) AS APIGenericSalesTier2
				FROM PharmacyMaster.[dbo].[PM_Rebates_APIMonthly] AS a
				INNER JOIN #T AS t ON a.PMID = t.PMID
										--AND a.Date = t.Date
				INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
				INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
				WHERE a.[Date] >= @StartDate
				AND a.Date <= @EndDate
				GROUP BY t.PMID
			) AS dt ON t.PMID = dt.PMID
						

	UPDATE t
	SET CAHBrandRx = dt.BrandRx
	, CAHExcludedRx = dt.ExcludedRx
	, CAHSourceGenericRx = dt.SourceGenericRx
	, CAHNonContractGenericRx = dt.NonContractGenericRx
	, CAHNetSourceGenerics = dt.NetSourceGenerics
	, CAHOTC = dt.OTC
	, CAHSuppliesOther = dt.SuppliesOther
	FROM #T AS t
	INNER JOIN(SELECT t.[PMID]
				, AVG(ISNULL([AAPBrand],0.00) - ISNULL([AAPExcludedFromTotalRX],0.00)) AS BrandRx --brand rx
				, AVG(ISNULL(a.AAPExcludedFromTotalRX,0.00)) AS ExcludedRx --excluded rx
				, AVG(ISNULL(a.AAPGENTotalSrc,0.00)) AS SourceGenericRx --source generic rx
				, AVG(ISNULL(a.AAPTotalRX,0.00) - ISNULL(a.AAPBrand,0.00) - ISNULL(a.AAPGENTotalSrc,0.00)) AS NonContractGenericRx
				, AVG(ISNULL(a.NetSourceGenerics,0.00)) AS NetSourceGenerics
				, AVG(ISNULL(AAPOTC,0.00)) AS OTC
				, AVG(ISNULL(a.AAPNonRXOTCandHH,0.00) - ISNULL(a.AAPOTC,0.00)) AS SuppliesOther
				FROM PharmacyMaster.[dbo].[CH_ALLPVA_SALES] AS a
				INNER JOIN #T AS t ON a.PMID = t.PMID
										--AND a.Date = t.Date
				INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON a.pmid = p.pmid
				INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
				INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
				WHERE a.Date >= @StartDate
				AND a.Date <= @Enddate
				GROUP BY t.PMID
			) AS dt ON t.PMID = dt.PMID



	SELECT dt.RN, dt.PMID, dt.AffiliateGroupName, dt.FirstDayOfMonth
	INTO #foo
	FROM(SELECT ROW_NUMBER() OVER(PARTITION BY dt.PMID ORDER BY dt.PMID ASC, ca.FirstDayOfMonth ASC) AS RN
		, dt.PMID, dt.AffiliateGroupName, ca.FirstDayOfMonth
		 FROM(SELECT CONVERT(INT,u.new_pmid) AS PMID
				, CONVERT(VARCHAR(50),a.[new_affiliategroupname]) AS AffiliateGroupName
				, ISNULL(CONVERT(DATETIME, a.[new_affiliationstart]),'19000101') AS AffiliationStartDate
				, ISNULL(CONVERT(DATETIME, a.[new_affiliationend]),'29991231') AS AffiliationEndDate
				FROM DynamicsODS.[dbo].[CRM_AffiliateHistory] AS a
				INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.[new_accountid] = u.accountid
				) AS dt
		CROSS APPLY(SELECT DISTINCT dt.PMID, dd.FirstDayOfMonth
					FROM SalesDDS.dbo.DateDim AS dd
					WHERE dd.TheDate BETWEEN dt.AffiliationStartDate AND dt.AffiliationEndDate	
					) AS ca
		WHERE dt.PMID = ca.PMID
		) AS dt
	CROSS APPLY(SELECT ISNULL(lj1.PMID,lj2.PMID) AS PMID
				, ISNULL(lj1.Date,lj2.Date) AS Date
				FROM RXMaster.dbo.PharmacyDim AS pd
				LEFT OUTER JOIN(SELECT PMID, Date
								 FROM PharmacyMaster.[dbo].[CH_ALLPVA_SALES]
								 WHERE Date BETWEEN @StartDate AND @EndDate
								 ) AS lj1 ON lj1.PMID = pd.PMID
				LEFT OUTER JOIN(SELECT PMID, Date
								 FROM PharmacyMaster.[dbo].[PM_Rebates_APIMonthly]
								 WHERE Date BETWEEN @StartDate AND @EndDate
								 ) AS lj2 ON lj2.PMID = pd.PMID
				WHERE (lj1.PMID IS NOT NULL
						OR lj2.PMID IS NOT NULL
						)
				AND (lj1.Date IS NOT NULL
					 OR lj2.Date IS NOT NULL
					 ) 
				) AS ca
	WHERE dt.PMID = ca.PMID
	AND dt.FirstDayOfMonth = ca.Date

	----Update Affiliation
	--DECLARE @MonthYear INT

	--SET @MonthYear = CONVERT(INT,CONVERT(VARCHAR(2),DATEPART(MM, @StartDate)) + CONVERT(VARCHAR(4),YEAR(@StartDate)))

	--SELECT ROW_NUMBER() OVER(PARTITION BY PMID ORDER BY PMID ASC, AffiliationStartDate ASC) AS RN
	--, dt.PMID, dt.AffiliateGroupName, dt.AffiliationStartDate, dt.AffiliationEndDate           
	--INTO #foo
	--FROM(SELECT CONVERT(INT,u.new_pmid) AS PMID
	--		, CONVERT(VARCHAR(50),a.[new_affiliategroupname]) AS AffiliateGroupName
	--		, ISNULL(CONVERT(DATETIME, a.[new_affiliationstart]),'19000101') AS AffiliationStartDate
	--		, ISNULL(CONVERT(DATETIME, a.[new_affiliationend]),'29991231') AS AffiliationEndDate
	--		FROM DynamicsODS.[dbo].[CRM_AffiliateHistory] AS a
	--		INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.[new_accountid] = u.accountid
	--		) AS dt
	--LEFT OUTER JOIN SalesDDS.dbo.DateDim AS dd ON dd.TheDate = dt.AffiliationStartDate  
	--LEFT OUTER JOIN SalesDDS.dbo.DateDim AS dd2 ON dd2.TheDate = dt.AffiliationEndDate  
	--LEFT OUTER JOIN SalesDDS.dbo.DateDim AS dd3 ON dd3.TheDate = @StartDate
	--LEFT OUTER JOIN SalesDDS.dbo.DateDim AS dd4 ON dd4.TheDate = @EndDate
	--WHERE dd.FirstDayOfMonth <= dd3.FirstDayOfMonth
	--AND ISNULL(dd2.LastDayOfMonth, '29991231')  >= ISNULL(dd4.LastDayOfMonth, '29991231') 
	--AND ISNULL(dd4.LastDayOfMonth, '29991231')  <= ISNULL(dd2.LastDayOfMonth, '29991231') 

	  

	--SELECT ROW_NUMBER() OVER(PARTITION BY PMID ORDER BY PMID ASC, AffiliationStartDate ASC) AS RN
	--	, dt.PMID, dt.AffiliateGroupName, dt.AffiliationStartDate, dt.AffiliationEndDate
	--	, dd.MMYYYY AS MonthYear
	--INTO #foo
	--FROM(SELECT CONVERT(INT,u.new_pmid) AS PMID
	--	, CONVERT(VARCHAR(50),a.[new_affiliategroupname]) AS AffiliateGroupName
	--	, ISNULL(CONVERT(DATETIME, a.[new_affiliationstart]),'19000101') AS AffiliationStartDate
	--	, ISNULL(CONVERT(DATETIME, a.[new_affiliationend]),'29991231') AS AffiliationEndDate
	--	FROM DynamicsODS.[dbo].[CRM_AffiliateHistory] AS a
	--	INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.[new_accountid] = u.accountid
	--	) AS dt
	--INNER JOIN SalesDDS.dbo.DateDim AS dd ON AffiliationStartDate = dd.TheDate
	--CROSS JOIN(SELECT DISTINCT MMYYYY AS StartMonthYear
	--			FROM SalesDDS.dbo.DateDim
	--			WHERE TheDate <= @StartDate
	--			AND TheDate >= DATEFROMPARTS ( DATEPART(yyyy, GETDATE()) - 1, 1, 1 ) --Beginning of previous year
	--			) AS cj
	--WHERE dd.MMYYYY = cj.StartMonthYear
	--ORDER BY dt.PMID ASC
	--, dt.AffiliationStartDate ASC

	--Get the most recent Affiliate based on the month and year
	UPDATE x
	SET x.Affiliate = s.AffiliateGroupName
	FROM #t AS x
	INNER JOIN(SELECT f.PMID, f.AffiliateGroupName
				FROM(SELECT MAX(RN) AS MAXRN
					, PMID
					FROM #foo
					GROUP BY PMID
					) AS dt
				INNER JOIN #foo AS f ON dt.MAXRN = f.RN
											AND dt.PMID = f.PMID
			)AS s ON x.PMID = s.PMID				


	SELECT c.TM
	, PMID
	, c.AAPAccountNumber
	, c.AAPParent
	, c.GroupID
	, c.AAPEffectiveDate
	, c.AAPQuitDate
	, c.Description
	, c.Affiliate
	, c.PharmacyName
	, c.City
	, c.State
	, c.Contact
  , AVG(CAST(c.TotalBRx AS MONEY)) AS TotalBRx
  , AVG(CAST(c.TotalGRx AS MONEY)) AS TotalGRx
  , AVG(CAST(c.NetSourceGenerics AS MONEY)) AS NetSourceGenerics
  , AVG(CAST(c.OtherRx AS MONEY)) AS OtherRx
  , AVG(CAST(c.NonRx AS MONEY)) AS NonRx
  , AVG(CAST(c.Excluded AS MONEY)) AS Excluded
  , AVG(CAST((c.TotalBRx + c.TotalGRx + c.OtherRx + c.NonRx + c.Excluded) AS MONEY)) AS AVGTotal
  , AVG(CAST(c.APIBrandSales AS MONEY)) AS APIBrand
  , AVG(CAST(c.APIGenericSales AS MONEY)) AS APIGen
  , AVG(CAST(c.APIOTCSales AS MONEY)) AS APIOTC
  , AVG(CAST(c.APIGenericSalesTier1 AS MONEY)) AS APIGenericSalesTier1
  , AVG(CAST(c.APIGenericSalesTier2 AS MONEY)) AS APIGenericSalesTier2 
 --INTO dbo.SR1169_20200716
 FROM(SELECT TM
		, PMID
		, AAPAccountNumber
		, AAPParent
		, GroupID
		, AAPEffectiveDate
		, AAPQuitDate
		, Description
		, Affiliate
		, PharmacyName
		, City
		, State
		, Contact
		, (CAHBrandRx + APIBrandSales) AS TotalBRx
		, (CAHSourceGenericRx + APIGen) AS TotalGRx  --CAH
		, (CAHNonContractGenericRx) AS OtherRx --CAH
		,  CAHNetSourceGenerics AS NetSourceGenerics --CAH
		, (CAHSuppliesOther + APIOTC + CAHOTC) AS NonRX --CAH
		, CAHExcludedRx AS Excluded
		, APIBrandSales
		, APIGen AS APIGenericSales
		, APIOTC AS APIOTCSales
		, APIGenericSalesTier1
		, APIGenericSalesTier2
		FROM #T 
		) AS c	
	GROUP BY c.TM
	, c.PMID
	, c.AAPAccountNumber
	, c.AAPParent
	, c.GroupID
	, c.AAPEffectiveDate
	, c.AAPQuitDate
	, c.Description
	, c.Affiliate
	, c.PharmacyName
	, c.City
	, c.State
	, c.Contact
	ORDER BY PMID ASC

END




 --    --Test DataSet for Date Range
 --    --Set @StartDate = '20181001'
 --    --Set @EndDate = '20181031'
 --    --Create Cardinal Temp Table
 --    DECLARE @tempCAH TABLE(PMID INT
	--						, Date               DATETIME
	--						, new_territoriesname      INT
	--						, accountname              NVARCHAR(255)
	--						, new_aap_account          NVARCHAR(100)
	--						, aapparentno              NVARCHAR(20)
	--						, new_group                NVARCHAR(100)
	--						, address1_city            NVARCHAR(255)
	--						, address1_stateorprovince NVARCHAR(255)
	--						, new_aap_effective_date   DATE
	--						, new_aapquit              DATE
	--						, BrandRx                  DECIMAL(18, 2)
	--						, ExcludedRx               DECIMAL(18, 2)
	--						, SourceGenericRx          DECIMAL(18, 2)
	--						, NonContractGenericRx     DECIMAL(18, 2)
	--						, OTC                      DECIMAL(18, 2)
	--						, SuppliesOther            DECIMAL(18, 2)
	--						--, MonthDate                INT
	--						 );


 --    --Create API Temp Table
 --    DECLARE @tempAPI TABLE
 --    (PMID            INT
 --   , Date      DATETIME
	--, new_territoriesname INT
	--, accountname              NVARCHAR(255)
 --   --, MonthDate       INT RSE 20190724
 --   , APIBrandSales   DECIMAL(18, 2)
 --   , APIGenericSales DECIMAL(18, 2)
 --   , APIOTCSales     DECIMAL(18, 2)
	--, [APIGenericSalesTier1] MONEY
	--, [APIGenericSalesTier2] MONEY
 --    );
 --    --INSERT INTO @tempAPI
 --    --SELECT av.PMID , av.Date, DATEPART(MM, Date) AS MonthDate, av.APIBrandSales, av.APIGenericSales, av.APIOTCSales
 --    --FROM dbo.APISales AS av 
 --    --WHERE av.Date >= @StartDate
 --    --       AND av.Date <= @EndDate;  


 --    INSERT INTO @tempAPI
	--(PMID
	--, Date
	--, new_territoriesname
	----, MonthDate RSE 20190724
	--, APIBrandSales
	--, APIGenericSales
	--, APIOTCSales
	--, [APIGenericSalesTier1]
	--, [APIGenericSalesTier2]
	--)
	--SELECT a.[PMID]
	--, a.Date
	--, new_territoriesname
	--, a.[Pharmacy Name] AS AccountName
	--, a.[API Brand Sales]
	--, a.[API Generic Sales]
	--, a.[API OTC Sales]
	--, a.[APIGenericSalesTier1]
	--, a.[APIGenericSalesTier2]
	--FROM PharmacyMaster.[dbo].[PM_Rebates_APIMonthly] AS a
	--INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
	--INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
	--WHERE [Date] >= @StartDate
	--AND Date <= @EndDate

	----SELECT av.PMID
 --   --, av.Date
 --   --, DATEPART(MM, Date) AS MonthDate
 --   --, WHAPIBrand AS BrandSales
 --   --, WHAPIGeneric AS GenericSales
 --   --, WHAPIOTC AS OTCSales
 --   --FROM [PharmacyMaster].dbo.ALL_Volume_New AS av
 --   --WHERE av.Date >= @StartDate
 --   --AND av.Date <= @EndDate
 --   --ORDER BY av.PMID;




	--INSERT INTO @tempCAH(PMID 
	--						, Date               
	--						, new_territoriesname      
	--						, accountname             
	--						, new_aap_account         
	--						, aapparentno              
	--						, new_group               
	--						, address1_city           
	--						, address1_stateorprovince 
	--						, new_aap_effective_date   
	--						, new_aapquit             
	--						, BrandRx                  
	--						, ExcludedRx              
	--						, SourceGenericRx          
	--						, NonContractGenericRx     
	--						, OTC                      
	--						, SuppliesOther 
	--						)          
	--SELECT a.[PMID]
	--, a.Date
	--, CASE	
	--	WHEN ISNUMERIC(u.new_territoriesname) = 1 THEN u.new_territoriesname
	--	ELSE NULL
	--	END AS TM
	--, a.AccountName AS PharmacyName
	--, u.new_aap_account AS AAPAccountNumber
	--, p.aapparentno AS AAPParent
	--, u.new_group AS GroupID
	--, ad.address1_city AS City
	--, ad.address1_stateorprovince AS State
	--, u.new_aap_effective_date AS AAPEffectiveDate
	--, u.new_aapquit AS AAPQuitDate
	--, [AAPBrand] - [AAPExcludedFromTotalRX] AS BrandRx --brand rx
	--, a.AAPExcludedFromTotalRX AS ExcludedRx --excluded rx
	--, a.AAPGENTotalSrc AS SourceGenericRx --source generic rx
	--, (a.AAPTotalRX - a.AAPBrand - a.AAPGENTotalSrc) AS NonContractGenericRx
	--, AAPOTC AS OTC
	--, (a.AAPNonRXOTCandHH - a.AAPOTC) AS SuppliesOther
	--FROM PharmacyMaster.[dbo].[CH_ALLPVA_SALES] AS a
	----INNER JOIN @tempAPI AS e ON e.PMID = a.PMID
	--INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON a.pmid = p.pmid
	--INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
	--INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
	--WHERE(a.Date >= @StartDate)
	--AND (a.Date <= @Enddate);

	----SELECT a.PMID
	----, a.date
	----, u.new_territoriesname AS TM
	----, a.AccountName AS PharmacyName
	----, u.new_aap_account AS AAPAccountNumber
	----, p.aapparentno AS AAPParent
	----, u.new_group AS GroupID
	----, ad.address1_city AS City
	----, ad.address1_stateorprovince AS State
	----, u.new_aap_effective_date AS AAPEffectiveDate
	----, u.new_aapquit AS AAPQuitDate
	----, (a.AAPBrand - a.AAPExcludedFromTotalRX) AS BrandRx --brand rx
	----, a.AAPExcludedFromTotalRX AS ExcludedRx --excluded rx
	----, a.AAPGENTotalSrc AS SourceGenericRx --source generic rx
	----, (a.AAPTotalRX - a.AAPBrand - a.AAPGENTotalSrc) AS NonContractGenericRx
	----, AAPOTC AS OTC
	----, (a.AAPNonRXOTCandHH - a.AAPOTC) AS SuppliesOther
	----, DATEPART(MM, a.Date) AS MonthDate
	----FROM [PharmacyMaster].dbo.ALL_Volume_New AS a
	----INNER JOIN @tempAPI AS e ON e.PMID = a.PMID
	----INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON a.pmid = p.pmid
	----INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
	----INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
	----WHERE(a.Date >= @StartDate)
	----AND (a.Date <= @Enddate);



	--SELECT PMID
	--, c.TM
	--, c.PharmacyName
	--, c.AAPAccountNumber
	--, c.AAPParent
	--, c.GroupID
	--, c.City
	--, c.State
	--, c.AAPEffectiveDate
	--, c.AAPQuitDate
	--, AVG(CAST(NULLIF(c.TotalBRx, 0) AS MONEY)) AS TotalBRx
	--, AVG(CAST(NULLIF(c.TotalGRx, 0) AS MONEY)) AS TotalGRx
	--, AVG(CAST(NULLIF(c.OtherRx, 0) AS MONEY)) AS OtherRx
	--, AVG(CAST(NULLIF(c.NonRx, 0) AS MONEY)) AS NonRx
	--, AVG(CAST(NULLIF(c.Excluded, 0) AS MONEY)) AS Excluded
	--, AVG(CAST(NULLIF((c.TotalBRx + c.TotalGRx + c.OtherRx + c.NonRx + c.Excluded), 0) AS MONEY)) AS AVGTotal
	--, AVG(CAST(NULLIF(c.APIBrandSales, 0) AS MONEY)) AS APIBrand
	--, AVG(CAST(NULLIF(c.APIGenericSales, 0) AS MONEY)) AS APIGen
	--, AVG(CAST(NULLIF(c.APIOTCSales, 0) AS MONEY)) AS APIOTC
	--FROM(SELECT ISNULL(a.PMID, b.PMID) AS PMID
	--	, ISNULL(a.new_territoriesname, b.new_territoriesname) AS TM
	--	, b.accountname AS PharmacyName
	--	, b.new_aap_account AS AAPAccountNumber
	--	, b.aapparentno AS AAPParent
	--	, b.new_group AS GroupID
	--	, b.address1_city AS City
	--	, b.address1_stateorprovince AS State
	--	, b.new_aap_effective_date AS AAPEffectiveDate
	--	, b.new_aapquit AS AAPQuitDate
	--	, a.Date
	--	, (b.BrandRx + a.APIBrandSales) AS TotalBRx
	--	, (b.SourceGenericRx + a.APIGenericSales) AS TotalGRx
	--	, (b.NonContractGenericRx) AS OtherRx
	--	, (b.SuppliesOther + a.APIOTCSales + b.OTC) AS NonRX
	--	, b.ExcludedRx AS Excluded
	--	, a.APIBrandSales
	--	, a.APIGenericSales
	--	, a.APIOTCSales
	--	FROM @tempAPI AS a
	--	FULL OUTER JOIN @tempCAH AS b ON a.PMID = b.PMID
	--										AND a.Date = b.Date
	--	WHERE a.PMID IS NOT NULL
	--		 OR b.PMID IS NOT NULL
	--	) AS c
	--GROUP BY c.TM
	--, c.PMID
	--, c.PharmacyName
	--, c.AAPAccountNumber
	--, c.AAPParent
	--, c.GroupID
	--, c.City
	--, c.State
	--, c.AAPEffectiveDate
	--, c.AAPQuitDate;






GO
