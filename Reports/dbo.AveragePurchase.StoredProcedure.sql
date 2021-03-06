USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[AveragePurchase]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[AveragePurchase]
@StartDate datetime, @EndDate datetime

AS
--Test DataSet for Date Range
--Set @StartDate = '20181001'
--Set @EndDate = '20181031'

--Create Cardinal Temp Table
DECLARE @tempCAH TABLE (PMID INT, TargetDate datetime, new_territoriesname int, accountname nvarchar(255), new_aap_account nvarchar(100), aapparentno nvarchar(20)
,new_group nvarchar(100), address1_city nvarchar(255), address1_stateorprovince nvarchar(255), new_aap_effective_date date, new_aapquit date, BrandRx Decimal(18,2),ExcludedRx Decimal (18,2)
						,SourceGenericRx Decimal (18,2), NonContractGenericRx Decimal (18,2)
						,OTC Decimal (18,2), SuppliesOther Decimal (18,2), MonthDate Int);
--Create API Temp Table
DECLARE @tempAPI TABLE (PMID INT, TargetDate datetime, MonthDate Int,APIBrandSales Decimal(18,2)
						,APIGenericSales Decimal (18,2),APIOTCSales Decimal (18,2));
--INSERT INTO @tempAPI
--SELECT av.PMID , av.Date, DATEPART(MM, Date) AS MonthDate, av.APIBrandSales, av.APIGenericSales, av.APIOTCSales
--FROM dbo.APISales AS av 
--WHERE av.Date >= @StartDate
--       AND av.Date <= @EndDate;     
INSERT INTO @tempAPI
SELECT av.PMID , av.Date, DATEPART(MM, Date) AS MonthDate, sum(APIBrandSales) as BrandSales, sum(APIGenericSales) as GenericSales, sum(APIOTCSales) as OTCSales
FROM dbo.APISales AS av 
WHERE av.Date >= @StartDate
       AND av.Date <= @EndDate
Group By av.PMID, av.Date
Order By av.PMID

INSERT INTO @tempCAH
      SELECT a.PMID,a.date, u.new_territoriesname AS TM, a.AccountName AS PharmacyName, u.new_aap_account AS AAPAccountNumber
	  ,p.aapparentno AS AAPParent, u.new_group AS GroupID, ad.address1_city AS City, ad.address1_stateorprovince AS State
	  ,u.new_aap_effective_date AS AAPEffectiveDate,u.new_aapquit AS AAPQuitDate
            ,(a.AAPBrand-a.AAPExcludedFromTotalRX) AS BrandRx --brand rx
          ,a.AAPExcludedFromTotalRX AS ExcludedRx --excluded rx
          ,a.AAPGENTotalSrc AS SourceGenericRx --source generic rx
          , (a.AAPTotalRX -a.AAPBrand -a.AAPGENTotalSrc) AS NonContractGenericRx
          , AAPOTC AS OTC
          , (a.AAPNonRXOTCandHH -a.AAPOTC) AS SuppliesOther
          , DATEPART(MM,a.Date) AS MonthDate
     FROM [PharmacyMaster].dbo.ALL_Volume_New AS a
	 INNER JOIN @tempAPI AS e ON e.PMID = a.PMID
	 INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p on a.pmid = p.pmid
	 INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS u ON a.PMID = u.new_pmid
	 INNER JOIN DynamicsODS.dbo.CRM_AccountEntity_Address AS ad ON u.accountid = ad.accountid
    WHERE(a.Date >= @StartDate)
                   AND (a.Date <= @Enddate)
SELECT   PMID, c.TM, c.PharmacyName, c.AAPAccountNumber, c.AAPParent, c.GroupID, c.City, c.State, c.AAPEffectiveDate, c.AAPQuitDate
	   , AVG(CAST(NULLIF(c.TotalBRx, 0) AS MONEY)) AS TotalBRx
	   , AVG(CAST(NULLIF(c.TotalGRx, 0) AS MONEY)) AS TotalGRx
       , AVG(CAST(NULLIF(c.OtherRx, 0) AS MONEY)) AS OtherRx
       , AVG(CAST(NULLIF(c.NonRx, 0) AS MONEY)) AS NonRx
       , AVG(CAST(NULLIF(c.Excluded, 0) AS MONEY)) AS Excluded
       , AVG(CAST(NULLIF((c.TotalBRx + c.TotalGRx + c.OtherRx + c.NonRx + c.Excluded), 0) AS MONEY)) AS AVGTotal
       , AVG(CAST(NULLIF(c.APIBrandSales, 0) AS MONEY)) AS APIBrand
       , AVG(CAST(NULLIF(c.APIGenericSales, 0) AS MONEY)) AS APIGen
       , AVG(CAST(NULLIF(c.APIOTCSales, 0) AS MONEY)) AS APIOTC
  
FROM 
(SELECT a.PMID, b.new_territoriesname AS TM, b.accountname AS PharmacyName, b.new_aap_account AS AAPAccountNumber, b.aapparentno AS AAPParent
,b.new_group AS GroupID, b.address1_city AS City, b.address1_stateorprovince AS State, b.new_aap_effective_date AS AAPEffectiveDate, b.new_aapquit AS AAPQuitDate
         , a.TargetDate
         , (b.BrandRx + a.APIBrandSales) AS TotalBRx
         , (b.SourceGenericRx + a.APIGenericSales) AS TotalGRx
         , (b.NonContractGenericRx) AS OtherRx
         , (b.SuppliesOther + a.APIOTCSales + b.OTC) AS NonRX
         , b.ExcludedRx AS Excluded
         , a.APIBrandSales
         , a.APIGenericSales
         , a.APIOTCSales
    FROM @tempAPI AS a
         INNER JOIN @tempCAH AS b ON a.PMID = b.PMID
		
) AS c
         GROUP BY c.TM, c.PMID, c.PharmacyName, c.AAPAccountNumber, c.AAPParent, c.GroupID, c.City, c.State, c.AAPEffectiveDate, c.AAPQuitDate;




GO
