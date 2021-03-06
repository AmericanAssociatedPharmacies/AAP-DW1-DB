USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIInstantRebate_QA]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Chris McKinnie>
-- Create date: <12/8/2017>
-- Description:	<Query to populate daily rebates on RXAAP.com>
-- =============================================
CREATE PROCEDURE [dbo].[usp_APIInstantRebate_QA]
	-- Add the parameters for the stored procedure here
	@APIAccountNumber varchar(8)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Type VarChar(1000) = 'Generic'
	DECLARE @InstantRebatePercentage Decimal(6,2) = 0.20

	SELECT [api2].[WHAccountID] AS [APIAccountNumber], 
		CONVERT(VARCHAR(10), [api2].[InvoiceDate], 101)	 As [InvoiceDate], 
		'$' + Cast(Cast([api2].[Sales] as decimal(18,2)) as varchar(10))  AS [VolumeAmount], 
		'$' + Cast(Cast([api2].[Rebate] as decimal(18,2)) as varchar(10)) AS [FullRebateAmount], 
		Cast(Cast(([api2].[Rebate] / [api2].[Sales]) * 100 as decimal(18,2)) as varchar(5)) + '%' AS [FullRebatePercentage], 
		Cast(Cast((([api2].[Rebate] / [api2].[Sales]) - @InstantRebatePercentage) * 100 as decimal(18,2)) as varchar(5)) + '%' AS [RemainingRebatePercentage], 
		'$' + Cast(Cast([api2].[Sales] * @InstantRebatePercentage as decimal(18,2)) as varchar(10)) AS [InstantRebate], 
		'$' + Cast(Cast(([api2].[Sales] * (([api2].[Rebate] / [api2].[Sales]) - @InstantRebatePercentage)) as decimal(18,2)) as varchar(10)) AS [RemainingRebate]
	FROM (
		SELECT MAX([api1].[InvDate]) AS [InvoiceDate], 
				COUNT(*) AS [TotalGenericPurchased],
				SUM([api1].[ExtSales]) AS [Sales], 
				SUM([api1].[Rebate]) AS [Rebate], 
				[api1].[WHAccountID]
		FROM api..[APISalesDetail] AS [api1]
		WHERE ([api1].[WHAccountID] = @APIAccountNumber) AND 
				([api1].[Type] = @Type) AND 
				([api1].[InvDate] = ((
				SELECT MAX(max_api.[InvDate])
				FROM API.dbo.[APISalesDetail] AS max_api
				)))
		GROUP BY [api1].[WHAccountID]
		HAVING COUNT(*) >= 5 
		) AS [api2]
    
END

GO
