USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_GenericLoyaltyTrend]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_GenericLoyaltyTrend]


AS

SET NOCOUNT ON;

BEGIN

DECLARE @StartYear DATETIME
, @CurrentDate DATETIME
, @GenLoyalty MONEY

	SET @StartYear = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0)
	SET @CurrentDate = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))
	SET @GenLoyalty = 36000.00


	SELECT p.APIAccountNo
	, p.AccountName
	, p.Email
	, p.Territory
	, dt.LastPurchaseDate
	, dt.CurrentGenericSales
	, dt.RemainingToGenericLoyalty
	FROM(SELECT WHAccountID
			, FORMAT(CONVERT(DATE, MAX([InvDate])), 'MM/dd/yyyy') AS LastPurchaseDate
			, CONVERT(MONEY, (SUM(ExtSales))) as CurrentGenericSales
			, CONVERT(MONEY, (SUM(ExtSales) - @GenLoyalty)) AS RemainingToGenericLoyalty
			FROM API.[dbo].[APISalesDetail]
			WHERE InvDate >= @StartYear
			AND InvDate < @CurrentDate
			AND Type = 'Generic'
			GROUP BY WHAccountID			
		) AS dt
	INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON dt.WHAccountID = p.APIAccountNo
	WHERE dt.RemainingToGenericLoyalty < 0
	ORDER BY p.AccountName ASC

END


GO
