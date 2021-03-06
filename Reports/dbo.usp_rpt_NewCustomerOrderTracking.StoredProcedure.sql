USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_NewCustomerOrderTracking]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_rpt_NewCustomerOrderTracking] 

       @StartDate DATETIME
       , @EndDate   DATETIME

AS

SET NOCOUNT ON;


BEGIN

		SELECT pm.PMID
		, pm.APIAccountNo
		, pm.AccountName
		, t.Territory
		, t.Name As TMName
		, ISNULL(sd.ExtSales,0) as Sales
		, ISNULL(sd.Qty,0) AS Qty 
		, MONTH(InvDate) as Mnth
		, YEAR(InvDate) as Yr
		, sd.Type
		, pd.APIAccountActivation as DateOpened
		, DATEDIFF(dd, pd.APIAccountActivation, @EndDate) AS AgeAsOfEndate
		FROM PharmacyMaster.dbo.v_PM_AllWithAffiliates as pm
		INNER JOIN SSRS.dbo.TerritoryManagers t on pm.territory = CONVERT(varchar,t.Territory)
		INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON pm.PMID = pd.PMID		
		LEFT OUTER JOIN(SELECT PMID
						, DATEADD(month, DATEDIFF(month, 0, InvDate), 0) as InvDate
						, Type
						, SUM(Qty) as Qty
						, SUM(ExtSales) as ExtSales
						FROM (SELECT s.PMID
									, InvDate
									, IIF(ExtSales < 0, Qty*-1, Qty) as Qty
									, ExtSales
									, Type
							FROM API.dbo.APISalesDetail AS s
							INNER JOIN RXMaster.dbo.PharmacyDim AS pd ON s.PMID = pd.PMID
							WHERE InvDate >= @StartDate
							AND InvDate <= @EndDate	
							AND pd.APIAccountActivation BETWEEN @StartDate AND @EndDate	
							AND Type IS NOT NULL
							) as a
					GROUP BY a.PMID, DATEADD(month, DATEDIFF(month, 0, InvDate), 0), Type
				) as sd ON pm.pmid = sd.PMID	
	WHERE pd.APIAccountActivation BETWEEN @StartDate AND @EndDate	
	ORDER BY pm.PMID ASC
	, MONTH(InvDate) ASC
	, YEAR(InvDate) ASC

END
GO
