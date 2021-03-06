USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_GenericLoyaltyTrend_Upload_CRM]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[usp_GenericLoyaltyTrend_Upload_CRM]

AS

SET NOCOUNT ON;

BEGIN



	SELECT dt.accountid
	, ISNULL(dt.new_apigenericsytd, '') AS new_apigenericsytd
	, dt.MaxPurchaseDate
	FROM(SELECT a.accountid, CONVERT(VARCHAR(25), [CurrentGenericSales]) AS new_apigenericsytd
			, lj.MaxPurchaseDate
			FROM DynamicsODS.dbo.CRM_AccountEntity_User AS a
			INNER JOIN [Staging].[GenericLoyaltyTrend] AS B on a.new_pmid = b.PMID	
			LEFT OUTER JOIN(SELECT pd.PMID
							, CONVERT(DATE, CONVERT(varchar(10), MAX(DateKey))) AS MaxPurchaseDate
							FROM SalesDDS.dbo.SalesFact_API AS s
							INNER JOIN SalesDDS.dbo.PharmacyDim AS pd ON s.PharmacyKey = pd.PharmacyKey
							WHERE pd.PMID NOT IN(0,999999)
							GROUP BY PMID			
							) AS lj ON a.new_pmid = lj.PMID	
		) AS dt


END






GO
