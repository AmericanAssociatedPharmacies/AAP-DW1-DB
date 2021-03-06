USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateReport_APITotals]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Chris McKinnie
-- Create date: 12/15/2017
-- =============================================
CREATE PROCEDURE [dbo].[usp_RebateReport_APITotals]
	-- Add the parameters for the stored procedure here
	@PMID Int,
	@PMIDList VARCHAR(50),
	@StartDate DATETIME2,
	@EndDate DATETIME2
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @CurrentYear Int = YEAR(@StartDate)
	DECLARE @PreviousYear Int = @CurrentYear - 1
	DECLARE @InstantRebatePercentage decimal(6,2) = 0.20
	DECLARE @Type VarChar(1000) = 'Generic'
	DECLARE @HighVolume decimal(18,2)
	DECLARE @APITotal decimal(18,2) = 0
	DECLARE @ApiAccountNumber VarChar(1000)

	/*SET API Number*/
	SELECT TOP 1 @ApiAccountNumber = [APIAccountNo] FROM [PharmacyMaster].[dbo].PM_Pharmacy WHERE [PMID] = @PMID
    
	/*---------------------------
		Temp Tables
	----------------------------*/
	--Master Tables
	DECLARE @tempAPITable TABLE ([RebateType] VARCHAR(50),[Jan] decimal(18,2),[Feb] decimal(18,2),[Mar] decimal(18,2),[Apr] decimal(18,2),[May] decimal(18,2),[Jun] decimal(18,2),[Jul] decimal(18,2),[Aug] decimal(18,2),[Sep] decimal(18,2),[Oct] decimal(18,2),[Nov] decimal(18,2),[Dec] decimal(18,2),[Annual] decimal(18,2))

	--API Tables
	DECLARE @tempAPIRebate TABLE([RebateFor] DateTime2,[GAC] decimal(18,2), [InstantRebate] decimal(18,2), [RemainingRebate] decimal(18,2))
	DECLARE @tempAPIBrand TABLE([CreditFor] DateTime2,[APIBrandRxIncentiveCredit] decimal(18,2))
	DECLARE @tempRebateGenericIncentive TABLE(RebateFor VARCHAR(4),RebateAmount decimal(18,2))
	DECLARE @tempArete2Table TABLE([RebateDate] DateTime2, [AreteAAPRebate] VARCHAR(50), [AreteAPIRebate] VARCHAR(50))


	/*******************************
			  API Rebates
	********************************/
	--FOR Instant and Monthly Rebates

	INSERT INTO @tempAPIRebate Select 
	Max([Date]) As [RebateFor],
	--Max([Sales]) AS [Sales],
	--Max([Rebate]) AS [Rebate],
	CASE WHEN @CurrentYear <= '2017' THEN 0 ELSE CAST(FLOOR(Max([Sales]) / 7000) * 26 AS Decimal(18,2)) END   AS [GAC],
	CASE WHEN @CurrentYear <= '2017' THEN 0 ELSE Max([Sales]) * @InstantRebatePercentage END AS [InstantRebate],
	CASE WHEN @CurrentYear <= '2017' THEN Max([Rebate]) ELSE Max([Sales]) * ((Max([Rebate]) / Max([Sales])) - @InstantRebatePercentage) END AS [RemainingRebate]	
FROM (SELECT  DATEFROMPARTS(Year([Date]), Month([Date]),1)AS [Date], [sd1].[API Generic Sales] AS [Sales], [sd1].[Net Rebate to Store] AS [Rebate]
FROM [PharmacyMaster].[dbo].[PM_Rebates_APIMonthly] AS [sd1]
WHERE ([sd1].[PMID] = @PMID) AND ([sd1].[Date] >= @StartDate) AND ([sd1].[Date] <= @EndDate)
UNION
SELECT [sd4].[value] AS [Date], [sd4].[value2] AS [Sales], [sd4].[value22] AS [Rebate]
FROM (
    SELECT [sd3].[value3] AS [value], [sd3].[value] AS [value2], [sd3].[value2] AS [value22]
    FROM (
        SELECT SUM([sd2].[ExtSales]) AS [value], SUM([sd2].[Rebate]) AS [value2], [sd2].[value] AS [value3]
        FROM (
            SELECT [sd1].[InvDate], DATEFROMPARTS(Year([sd1].[InvDate]), Month([sd1].[InvDate]),1) AS [value], [sd1].[ExtSales], [sd1].[Rebate], [sd1].[WHAccountID], [sd1].[Type]
            FROM [API].[dbo].[APISalesDetail] AS [sd1]
            ) AS [sd2]
        WHERE ([sd2].[WHAccountID] = @ApiAccountNumber) AND ([sd2].[value] >
		(SELECT TOP 1 [Date] FROM [PharmacyMaster].[dbo].[PM_Rebates_APIMonthly] ORDER BY [Date] DESC)
		) AND ([sd2].[value] >= @StartDate) AND ([sd2].[value] <= @EndDate) AND ([sd2].[Type] = @Type)
        GROUP BY [sd2].[value]
        ) AS [sd3]
    ) AS [sd4]) As Data
	Group By Date
	Order By Date

	--Instant Rebate
	IF @currentYear >= 2018
	BEGIN
		INSERT INTO @tempAPITable SELECT 
		'Instant Rebate' As [RebateType],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 1 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 2 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 3 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 4 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 5 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 6 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 7 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 8 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 9 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 10 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 11 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 12 THEN CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
		ISNULL(SUM(CAST(REPLACE(InstantRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
		FROM @tempAPIRebate
	END
	--Monthly Rebate
	INSERT INTO @tempAPITable SELECT 
	'Monthly Rebate' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 1 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 2 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 3 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 4 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 5 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 6 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 7 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 8 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 9 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 10 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 11 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 12 THEN CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(RemainingRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempAPIRebate
	
	--Generic Achievement Credit (GAC)
	IF(@CurrentYear > 2017)
	BEGIN
		INSERT INTO @tempAPITable SELECT 
		'Generic Achievement Credit (GAC)' As [RebateType],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 1 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 2 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 3 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 4 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 5 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 6 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 7 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 8 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 9 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 10 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 11 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
		ISNULL(SUM(CASE WHEN MONTH(RebateFor) = 12 THEN CAST(REPLACE(GAC,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
		ISNULL(SUM(CAST(REPLACE(GAC,'$','') AS decimal(18,2))), 0) AS [Annual]
		FROM @tempAPIRebate
	END
	--Brand Rx Credit
	INSERT INTO @tempAPIBrand SELECT
	MAX([Credit For]) [CreditFor],
	MAX([API Brand Rx Incentive Credit]) [APIBrandRxIncentiveCredit]
	FROM (
		SELECT  
		CAST([Date] AS DATETIME2)  as [Credit For],
		[Brand Credits Disbursed] as [API Brand Rx Incentive Credit]
		FROM pharmacymaster.dbo.v_web_PM_Rebates_APIMonthly
		WHERE [date] >= @startDate AND [date] <= @endDate AND pmid in (select * from dbo.ufn_CommaListToTable(@PMIDList))
		UNION
		SELECT TOP 12
		CAST([Date] AS DATETIME2)  as [Credit For],
		[BrandCredits] as [API Brand Rx Incentive Credit]
		FROM pharmacymaster.dbo.PM_BrandCredits_APIMonthly
		WHERE [date] >= @startDate AND [date] <= @endDate AND pmid in (select * from dbo.ufn_CommaListToTable(@PMIDList))
	) dt GROUP BY [Credit For] 
	ORDER BY [Credit For]
	
	INSERT INTO @tempAPITable SELECT 
	'Brand Rx Credit' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 1 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 2 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 3 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 4 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 5 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 6 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 7 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 8 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 9 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 10 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 11 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(CreditFor) = 12 THEN CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(APIBrandRxIncentiveCredit,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempAPIBrand

	--Generic Loyalty
	INSERT INTO @tempRebateGenericIncentive Select Top 1
	[Year] AS [RebateFor],
	[GenericIncentive] as [RebateAmount]
	FROM PharmacyMaster.dbo.PM_AnnualRebates
	WHERE pmid = @PMID AND [Year] = @previousYear

	IF((SELECT COUNT(*) FROM @tempRebateGenericIncentive) > 0)
		BEGIN
			INSERT INTO @tempAPITable SELECT 
			'Generic Loyalty Rebate+' As [RebateType],
			0 AS [Jan],
			0 AS [Feb],
			0 AS [Mar],
			0 AS [Apr],
			0 AS [May],
			0 AS [Jun],
			0 AS [Jul],
			0 AS [Aug],
			0 AS [Sep],
			0 AS [Oct],
			0 AS [Nov],
			0 AS [Dec],
			CAST(RebateAmount AS decimal(18,2)) AS [Annual]
			FROM @tempRebateGenericIncentive
		END
	ELSE
		BEGIN
			INSERT INTO @tempAPITable SELECT 
			'Generic Loyalty Rebate+' As [RebateType],
			0 AS [Jan],
			0 AS [Feb],
			0 AS [Mar],
			0 AS [Apr],
			0 AS [May],
			0 AS [Jun],
			0 AS [Jul],
			0 AS [Aug],
			0 AS [Sep],
			0 AS [Oct],
			0 AS [Nov],
			0 AS [Dec],
			0 AS [Annual]
		END

	--Arete Credit
	INSERT INTO @tempArete2Table SELECT 
	[Date] as [RebateDate]
	,CASE WHEN [Arete - AAP Rebate] = -1.0 THEN 0 ELSE CAST([Arete - AAP Rebate] AS decimal(18,2)) END AS [AreteAAPRebate]
	,CASE WHEN [Arete - API Rebate] = -1.0 THEN 0 ELSE CAST([Arete - API Rebate] AS decimal(18,2)) END AS [AreteAPIRebate]
	FROM
	(
	SELECT
	[date]
	,SUM([Arete - AAP Rebate]) AS [Arete - AAP Rebate]
	,SUM([Arete - API Rebate]) AS [Arete - API Rebate]

	FROM
	(
		SELECT TOP 12
		[date] 
		,ISNULL([AretePerformanceRebate],-1.0) AS [Arete - AAP Rebate] --use negative as a null flag
		,0 AS [Arete - API Rebate]
		FROM
		pharmacymaster.dbo.PM_Rebates_CHAAP
		WHERE pmid = @PMID AND [date] >= @startDate AND [date] <= @endDate
		ORDER BY [date] DESC
	UNION

		SELECT TOP 12
		[date]
		,0 AS [Arete - AAP Rebate]
		,ISNULL(AreteRebateFee,-1.0) AS [Arete - API Rebate]  --use negative as a null flag
		FROM
		pharmacymaster.dbo.v_web_PM_Rebates_APIMonthly
		WHERE pmid = @PMID AND [date] >= @startDate AND [date] <= @endDate
		ORDER BY [date] DESC
	) dt
		GROUP BY [Date]
	) dt2
		ORDER BY [Date] desc

	INSERT INTO @tempAPITable SELECT 
	'Arete Credit' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(AreteAPIRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempArete2Table

	/*---------------------------
		API Totals
	----------------------------*/
	INSERT INTO @tempAPITable SELECT 
	'Total Benefits*' As [RebateType],
	SUM([Jan]) AS [Jan],
	SUM([Feb]) AS [Feb],
	SUM([Mar]) AS [Mar],
	SUM([Apr]) AS [Apr],
	SUM([May]) AS [May],
	SUM([Jun]) AS [Jun],
	SUM([Jul]) AS [Jul],
	SUM([Aug]) AS [Aug],
	SUM([Sep]) AS [Sep],
	SUM([Oct]) AS [Oct],
	SUM([Nov]) AS [Nov],
	SUM([Dec]) AS [Dec],
	SUM([Annual]) AS [Annual]
	FROM @tempAPITable


	/*---------------------------
		Display Totals
	----------------------------*/
	SELECT * FROM @tempAPITable AS [API]
END

GO
