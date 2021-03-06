USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateReport_AAPTotals]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Chris McKinnie
-- Create date: 12/15/2017
-- =============================================
CREATE PROCEDURE [dbo].[usp_RebateReport_AAPTotals]
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
	DECLARE @AAPTotal decimal(18,2) = 0
    
	/*---------------------------
		Temp Tables
	----------------------------*/
	--Master Tables
	DECLARE @tempAAPTable TABLE ([RebateType] VARCHAR(50),[Jan] decimal(18,2),[Feb] decimal(18,2),[Mar] decimal(18,2),[Apr] decimal(18,2),[May] decimal(18,2),[Jun] decimal(18,2),[Jul] decimal(18,2),[Aug] decimal(18,2),[Sep] decimal(18,2),[Oct] decimal(18,2),[Nov] decimal(18,2),[Dec] decimal(18,2),[Annual] decimal(18,2))

	--AAP Tables
	DECLARE @tempRebatePreferredPartner TABLE(RebateFor VARCHAR(4),RebateAmount decimal(18,2))
	DECLARE @tempPMAnnualRebate TABLE (Year VARCHAR(4),RebateAmount decimal(18,2))
	DECLARE @tempAreteTable TABLE([RebateDate] DateTime2, [AreteAAPRebate] VARCHAR(50), [AreteAPIRebate] VARCHAR(50))
	DECLARE @tempPatronageDividend TABLE(RebateAmount decimal(18,2))

	/*******************************
			  AAP Rebates
	********************************/
	/*---------------------------
		Preferred Partners
	----------------------------*/

	--[dbo].[usp_RebatePreferredPartner]
	INSERT INTO @tempRebatePreferredPartner SELECT TOP 1
	Period as [RebateFor],CASE WHEN Affiliate = 'PIPCO' THEN ISNULL([PaymentAmt],0) ELSE (ISNULL([Paid To Store],0) + ISNULL([Paid To Affiliate],0)) END as [RebateAmount]
	FROM pharmacymaster.dbo.pm_rebates_ppartner
	WHERE pmid = @PMID AND Period = CAST(@previousYear AS VARCHAR(50))
		
	IF ((SELECT COUNT(*) FROM @tempRebatePreferredPartner) > 0)
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Preferred Partner Rebate+' As [RebateType],
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
			FROM @tempRebatePreferredPartner
		END
	ELSE
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Preferred Partner Rebate+' As [RebateType],
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

	/*---------------------------
		Retail Planograms
	----------------------------*/

	--[dbo].[usp_RebatePlanogram]
	INSERT INTO @tempPMAnnualRebate SELECT TOP 1 [Year],[PlanOGramRebate] as [RebateAmount]
	FROM PharmacyMaster.dbo.PM_AnnualRebates
	WHERE pmid = @PMID AND [Year] = @previousYear

	IF((SELECT COUNT(*) FROM @tempPMAnnualRebate) > 0)
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Retail Planograms Rebate+' As [RebateType],
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
			ISNULL(CAST(RebateAmount AS decimal(18,2)),0) AS [Annual]
			FROM @tempPMAnnualRebate
		END
	ELSE
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Retail Planograms Rebate+' As [RebateType],
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

	/*---------------------------
		Arete
	----------------------------*/

	--[dbo].[usp_RebateAretePerformance]
	INSERT INTO @tempAreteTable SELECT 
	[Date] as [RebateDate]
	,CASE WHEN [Arete - AAP Rebate] = -1.0 THEN 0 ELSE CAST([Arete - AAP Rebate] AS decimal(18,2)) END AS [AreteAAPRebate]
	,CASE WHEN [Arete - API Rebate] = -1.0 THEN 0 ELSE CAST([Arete - AAP Rebate] AS decimal(18,2)) END AS [AreteAPIRebate]
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

	INSERT INTO @tempAAPTable SELECT 
	'Arete Credit' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2)) END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(AreteAAPRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempAreteTable


	/*---------------------------
		Patronage Dividend
	----------------------------*/
	INSERT INTO @tempPatronageDividend SELECT [PatronageDividend]
	FROM WebDev.dbo.V_PM_AnnualRebates
	WHERE [YEAR] = @previousYear AND [PMID] = @PMID

	IF((SELECT COUNT(*) FROM @tempPatronageDividend) > 0)
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Patronage Dividend+' As [RebateType],
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
			FROM @tempPatronageDividend
		END
	ELSE
		BEGIN
			INSERT INTO @tempAAPTable SELECT 
			'Patronage Dividend+' As [RebateType],
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

	/*---------------------------
		Totals
	----------------------------*/

	SELECT @AAPTotal =SUM([Annual]) FROM @tempAAPTable

	INSERT INTO @tempAAPTable SELECT 
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
	FROM @tempAAPTable


	/*---------------------------
		Display Totals
	----------------------------*/
	SELECT * FROM @tempAAPTable AS [AAP]
	--SELECT * FROM @tempAPITable AS [API]
	--SELECT * FROM @tempCardinalHealthTable AS [CardinalHealth]
	--SELECT * FROM @tempOverAllMonthlyTotalRollUpTable AS [MonthlyOverAllTotal]
	--SELECT * FROM @tempOverAllTotalTable AS [OverAllTotal]
END

GO
