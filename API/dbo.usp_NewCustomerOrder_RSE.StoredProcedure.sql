USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_NewCustomerOrder_RSE]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_NewCustomerOrder_RSE] 

	@P1 INT

AS
     
SET NOCOUNT ON;
 BEGIN

	DECLARE @d1 DATETIME
	, @d2 DATETIME

	SET @d1 = GETDATE();
	SET @d2 = DATEADD(yy, DATEDIFF(yy, 0, @d1), 0);

	DECLARE @T TABLE(APIAccountNo VARCHAR(255)
					, AccountName VARCHAR(255)
					, Territory INT
					, TMName VARCHAR(255)
					, TotalSalesYTD MONEY
					, QtyYTD INT
					, [Type] VARCHAR(255)
					, MonthOfYear INT
					, DateOpened DATE
					, BizAge INT	
					--,  INDEX IX_Priyanka NONCLUSTERED(TotalSalesYTD desc) 
					)
             
	INSERT INTO @T(APIAccountNo
					, AccountName 
					, Territory 
					, TMName 
					, TotalSalesYTD 
					, QtyYTD 
					, [Type] 
					, MonthOfYear 
					, DateOpened 
					, BizAge
					) 
	SELECT d1.APIAccountNo
	, d1.AccountName
	, d1.Territory
	, d1.TMName
	, CONVERT(MONEY, d1.TotalSalesYTD)
	, d1.QtyYTD
	, d1.Type
	, d1.MonthOfYear
	, d1.DateOpened
	, BizAge
	FROM(SELECT pm.APIAccountNo
			 , pm.AccountName
			 , sd.Territory
			 , CONCAT(pm.TMFirstName, ' ', pm.TMLastName) AS TMName
			 --, FORMAT(SUM(sd.ExtSales), 'C') AS TotalSalesYTD
			 , SUM(sd.ExtSales) AS TotalSalesYTD
			 , SUM(sd.Qty) AS QtyYTD
			 , sd.Type
			 , dd.MonthOfYear
			 , pm.DateOpened
			 , SalesDDS.dbo.fn_APIBusinessDays(pm.DateOpened, @d1) AS BizAge
		FROM API.dbo.APISalesDetail AS sd
			 JOIN PharmacyMaster.dbo.v_PM_AllWithAffiliates AS pm ON sd.WHAccountID = pm.APIAccountNo
			 JOIN Rx30.dbo.DateDim AS dd ON sd.InvDate = dd.TheDate
		WHERE sd.InvDate BETWEEN @d2 AND @d1
		  --AND sd.WHAccountID = '01010246'
		  AND pm.APIAccountNo = '31042131'
		GROUP BY pm.APIAccountNo
			   , pm.AccountName
			   , sd.Territory
			   , pm.TMFirstName
			   , pm.TMLastName
			   , sd.Type
			   , pm.DateOpened
			   , dd.MonthOfYear
	) AS d1
	WHERE d1.BizAge <= @P1
	ORDER BY d1.TotalSalesYTD DESC


	SELECT APIAccountNo
	, AccountName 
	, Territory 
	, TMName 
	, FORMAT(TotalSalesYTD, 'C') AS TotalSalesYTD
	, QtyYTD 
	, [Type] 
	, MonthOfYear 
	, DateOpened 
	, BizAge
	FROM(SELECT ROW_NUMBER() OVER(ORDER BY TotalSalesYTD DESC) AS RN
		, APIAccountNo
		, AccountName 
		, Territory 
		, TMName 
		, TotalSalesYTD
		, QtyYTD 
		, [Type] 
		, MonthOfYear 
		, DateOpened 
		, BizAge
	FROM @T
	) AS dt
	ORDER BY dt.RN ASC

END;



GO
