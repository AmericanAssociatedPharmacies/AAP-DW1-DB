USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_RebateReport_CardinalTotals]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Chris McKinnie
-- Create date: 12/15/2017
-- =============================================
CREATE PROCEDURE [dbo].[usp_RebateReport_CardinalTotals]
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
	DECLARE @CardinalHealthTotal decimal(18,2) = 0
    
	/*---------------------------
		Temp Tables
	----------------------------*/
	--Master Tables
	DECLARE @tempCardinalHealthTable TABLE ([RebateType] VARCHAR(50),[Jan] decimal(18,2),[Feb] decimal(18,2),[Mar] decimal(18,2),[Apr] decimal(18,2),[May] decimal(18,2),[Jun] decimal(18,2),[Jul] decimal(18,2),[Aug] decimal(18,2),[Sep] decimal(18,2),[Oct] decimal(18,2),[Nov] decimal(18,2),[Dec] decimal(18,2),[Annual] decimal(18,2))

	--Cardinal Health Tables
	DECLARE @tempCardinalHealth TABLE([RebateDate] DateTime2, [GenericSales] decimal(18,2), [GenericRebatesAmount] decimal(18,2), LeaderRebate decimal(18,2),CalculatedLeaderRebate decimal(18,2), PriceProtection decimal(18,2))
	DECLARE @tempHighVolumeRebate TABLE([RebateDate] DateTime2, [HighVolumeRebate] decimal(18,2))



	/*******************************
		 Cardinal Health Rebates
	********************************/
	--Cardinal Health Data
	INSERT INTO @tempCardinalHealth SELECT top 12
		[Date] AS [RebateDate],
		[SourceGenericSales] AS [GenericSales],
		[GenericRebate] AS [GenericRebateAmount],
		[LeaderRebate] AS [LeaderRebate],
		([SourceGenericSales] / 7000 * 26.00) AS [CalculatedLeaderRebate],
		isnull([PriceProtectionRebate],0) AS [PriceProtection]
		FROM
		pharmacymaster.dbo.PM_Rebates_CHAAP
		WHERE pmid = @PMID AND [Date] >= @startDate AND [date] <= @endDate

	--Monthly Rebate
	INSERT INTO @tempCardinalHealthTable SELECT 
	'Monthly Rebate' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(GenericRebatesAmount,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempCardinalHealth

	--Leader Quarterly Rebate
	INSERT INTO @tempCardinalHealthTable SELECT 
	'Leader Quarterly Rebate' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(LeaderRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempCardinalHealth

	--High Volume Rebate (Hide if no HVR)
	SELECT  @HighVolume = sum(isnull([high volume incentive],0))
	FROM pharmacymaster.dbo.pm_rebates_highvolume
	WHERE PMID = @PMID AND [Date] >= @startDate AND [Date] <= @endDate
	GROUP BY [Date]
	ORDER BY [Date] DESC

	IF @HighVolume <> 0
	BEGIN
		INSERT INTO @tempHighVolumeRebate SELECT
		[Date] as [RebateDate],
		Cast([high volume incentive] AS decimal(18,2)) AS [HighVolumeRebate]
		FROM
		pharmacymaster.dbo.pm_rebates_highvolume
		WHERE PMID = @PMID AND [Date] >= @startDate AND [Date] <= @endDate
		ORDER BY [Date]
	
		INSERT INTO @tempCardinalHealthTable SELECT 
		'High Volume Rebate' As [RebateType],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
		ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
		ISNULL(SUM(CAST(REPLACE(HighVolumeRebate,'$','') AS decimal(18,2))), 0) AS [Annual]
		FROM @tempHighVolumeRebate
	END

	--Price Protection
	INSERT INTO @tempCardinalHealthTable SELECT 
	'Price Protection Rebate' As [RebateType],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 1 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jan],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 2 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Feb],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 3 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Mar],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 4 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Apr],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 5 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [May],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 6 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jun],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 7 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Jul],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 8 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Aug],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 9 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Sep],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 10 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Oct],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 11 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Nov],
	ISNULL(SUM(CASE WHEN MONTH(RebateDate) = 12 THEN CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2)) ELSE 0 END), 0) AS [Dec],
	ISNULL(SUM(CAST(REPLACE(PriceProtection,'$','') AS decimal(18,2))), 0) AS [Annual]
	FROM @tempCardinalHealth
	/*---------------------------
		Cardinal Health Totals
	----------------------------*/

	INSERT INTO @tempCardinalHealthTable SELECT 
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
	FROM @tempCardinalHealthTable

	/*---------------------------
		Display Totals
	----------------------------*/
	SELECT * FROM @tempCardinalHealthTable AS [CardinalHealth]
END

GO
