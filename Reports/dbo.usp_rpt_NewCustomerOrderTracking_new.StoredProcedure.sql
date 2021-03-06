USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_NewCustomerOrderTracking_new]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




--------------------------------------------------------------------------------------------------
 --Reference Only to Update Table LM
 --SELECT s.ownerid, s.owneridname, u.new_pmid
  --FROM [ODSIntake].[Staging].[CRM_AccountEntity_Sys] AS s
  --INNER JOIN [ODSIntake].[Staging].[CRM_AccountEntity_User] AS u ON s.accountid = u.accountid
----------------------------------------------------------------------------------------------------


CREATE PROCEDURE [dbo].[usp_rpt_NewCustomerOrderTracking_new] 

       @StartDate DATETIME
       , @EndDate   DATETIME

AS
       
SET NOCOUNT ON;

BEGIN

	DECLARE @StartDateKey INT
	, @EndDateKey INT

	
	SET @StartDateKey = SalesDDS.dbo.fn_ConvertDateTimeToDateKey(@StartDate)
	SET @EndDateKey = SalesDDS.dbo.fn_ConvertDateTimeToDateKey(@EndDate)
              

	SELECT dt.pmid AS PMID
	,ap.new_api_account AS APIAccountNo
	--, u.accountid GUID value. Has no business meaning. Internal value only.
	, s.name AS AccountName
	--, s.ownerid GUID value. Has no business meaning. Internal value only.
	, u.new_territoriesname AS Territory
	, s.owneridname AS TMName
	, dt.Sales 
	, dt.Qty
	, MONTH(dt.InvDate) as Mnth
	, YEAR(dt.InvDate) as Yr
	, dt.Type
	, pd.FirstSalesDate as DateOpened
	, DATEDIFF(dd, pd.FirstSalesDate, @EndDate) AS AgeAsOfEndate
	FROM [DynamicsODS].[dbo].[CRM_AccountEntity_Sys] AS s --PharmacyMaster.dbo.v_PM_AllWithAffiliates as pm
	INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_User] AS u ON s.accountid = u.accountid    --SSRS.dbo.TerritoryManagers t on pm.territory = CONVERT(varchar,t.Territory)
	INNER JOIN [DynamicsODS].[dbo].[CRM_AccountEntity_API] AS ap ON u.accountid = ap.accountid
	INNER JOIN(SELECT pd.PMID
					, DATEADD(month, DATEDIFF(month, 0, dd.TheDate), 0) as InvDate
					, e.Type
					, SUM(s.[APIInvoiceQuantity]) AS Qty
					, SUM(s.[APIExtendedAmount]) AS Sales					
					FROM SalesDDS.dbo.SalesFact_API AS s
					INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON s.APIEventKey = e.EventKey
																AND s.APIEventDateKey = e.DateKey
					INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON s.PharmacyKey = pd.PharmacyKey
					INNER JOIN SalesDDS.dbo.DateDim AS dd ON s.DateKey = dd.DateKey
					WHERE s.DateKey BETWEEN @StartDateKey AND @EndDateKey
					AND e.Type IS NOT NULL
					GROUP BY pd.PMID, DATEADD(month, DATEDIFF(month, 0, dd.TheDate), 0), e.Type
					) AS dt ON dt.PMID = CONVERT(INT,u.new_pmid)
	INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON dt.PMID = pd.PMID
	ORDER BY dt.PMID ASC, dt.Type ASC
												

		--INNER JOIN (
	--                               SELECT l.PMID
	--                                      , l.APIAccountNo
	--                                      , l.API_PMID_EffectiveDate
	--                               FROM PharmacyMaster.dbo.v_APItoPMID_LifeTime as l
	--                               WHERE l.API_PMID_EffectiveDate >= @StartDate 
	--                               AND l.API_PMID_EffectiveDate < DATEADD(day, 1, @EndDate)
	--                        ) as a
	--         ON u.new_pmid = a.PMID
	--INNER JOIN(SELECT pd.PMID
	--				, DATEADD(month, DATEDIFF(month, 0, dd.TheDate), 0) as InvDate
	--				, e.Type
	--				, SUM(s.[APIInvoiceQuantity]) AS Qty
	--				, SUM(s.[APIExtendedAmount]) AS Sales					
	--				FROM SalesDDS.dbo.SalesFact_API AS s
	--				INNER JOIN SalesDDS.dbo.EventDimAPI AS e ON s.APIEventKey = e.EventKey
	--															AND s.APIEventDateKey = e.DateKey
	--				INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON s.PharmacyKey = pd.PharmacyKey
	--				INNER JOIN SalesDDS.dbo.DateDim AS dd ON s.DateKey = dd.DateKey
	--				WHERE s.DateKey BETWEEN @StartDateKey AND @EndDateKey
	--				AND e.Type IS NOT NULL
	--				GROUP BY pd.PMID, DATEADD(month, DATEDIFF(month, 0, dd.TheDate), 0), e.Type
	--				) AS dt ON pd.PMID = u.new_PMID
		--LEFT JOIN (SELECT WHAccountID
		--			, DATEADD(month, DATEDIFF(month, 0, InvDate), 0) as InvDate
		--			, Type
		--			, SUM(Qty) as Qty
		--			, SUM(ExtSales) as ExtSales
		--			FROM (SELECT WHAccountID
		--					, InvDate
		--					, IIF(ExtSales < 0, Qty*-1, Qty) as Qty
		--					, ExtSales
		--					, Type
		--					FROM API.dbo.APISalesDetail
		--					WHERE InvDate >= @StartDate
		--					AND Type IS NOT NULL
		--				) as a
		--			GROUP BY WHAccountID, DATEADD(month, DATEDIFF(month, 0, InvDate), 0), Type
		--				) as sd
		--ON ap.new_api_account = sd.WHAccountID



END

GO
