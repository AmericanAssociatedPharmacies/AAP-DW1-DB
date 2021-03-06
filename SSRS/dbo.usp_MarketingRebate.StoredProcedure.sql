USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_MarketingRebate]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_MarketingRebate] @Month INT, 
                                            @Year  INT
AS
     SET NOCOUNT ON;
    BEGIN
        SELECT a.PMID, 
               b.APIAccountNo AS API, 
               b.AccountName AS Name, 
               ISNULL(b.ACHEmail, b.Email) AS Email, 
               a.[Rebate Administrator] AS Affiliate, 
               a.[Net Rebate to Store] AS Rebate
        FROM PharmacyMaster.dbo.PM_Rebates_APIMonthly_New AS a
             INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS b ON a.PMID = b.PMID
        WHERE MONTH(a.[Date]) = @Month
              AND YEAR(a.[Date]) = @Year
			  AND a.[Net Rebate to Store] >= 15
    END;
GO
