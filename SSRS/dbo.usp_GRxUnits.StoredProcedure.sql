USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GRxUnits]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GRxUnits]
AS
     SET NOCOUNT ON;
    BEGIN
        --API--
        DECLARE @APITemp TABLE
        (Month       INT
       , PMID        INT
       , AccountName VARCHAR(100)
       , ST          VARCHAR(2)
       , City        VARCHAR(100)
       , Year        INT
       , Total       INT
        );
        INSERT INTO @APITemp
               SELECT MONTH(b.InvDate) AS Month
                    , b.PMID
                    , b.AccountName
                    , b.PhysicalLocationStateCode AS ST
                    , b.PhysicalLocationCity AS City
                    , YEAR(b.InvDate) AS Year
                    , SUM(b.Units) AS Total
               FROM
               (
                   SELECT a.InvNbr
                        , a.InvDate
                        , c.PMID
                        , c.AccountName
                        , d.PhysicalLocationCity
                        , d.PhysicalLocationStateCode
                        , SUM(a.ExtSales) AS Sales
                        , CASE
                              WHEN SUM(a.ExtSales) < 0
                              THEN(-1 * SUM(a.Qty))
                              ELSE SUM(a.Qty)
                          END AS Units
                   FROM SSRS.dbo.APISalesDetail AS a
                        INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS c ON a.WHAccountID = c.APIAccountNo
                        INNER JOIN NCPDPODS.dbo.ProviderInformation AS d ON c.NCPDP = d.NCPDPProviderID
                   WHERE YEAR(a.InvDate) >= 2018
                         AND a.Type = 'Generic'
                   GROUP BY a.InvNbr
                          , a.InvDate
                          , c.PMID
                          , c.AccountName
                          , d.PhysicalLocationCity
                          , d.PhysicalLocationStateCode
               ) AS b
               GROUP BY MONTH(b.InvDate)
                      , YEAR(b.InvDate)
                      , b.PMID
                      , b.AccountName
                      , b.PhysicalLocationCity
                      , b.PhysicalLocationStateCode;

        --CAH--
        DECLARE @CAHTemp TABLE
        (Month INT
       , PMID  INT
       , YEAR  INT
       , Units INT
        );
        INSERT INTO @CAHTemp
               SELECT MONTH(a.INV_DATE) AS Month
                    , a.PMID
                    , YEAR(a.INV_DATE) AS Year
                    , SUM(a.SHIP_QTY) AS Units
               FROM SSRS.dbo.CAHSales AS a
               WHERE a.ITEM_TYPE = 'Rx'
                     AND a.BRAND = 'N'
                     AND YEAR(a.INV_DATE) >= 2018
               GROUP BY MONTH(a.INV_DATE)
                      , YEAR(a.INV_DATE)
                      , a.PMID;

        --Combined--

        SELECT c.Territory
             , a.PMID
             , c.AAPAccountNo AS AAPNum
             , c.AAPParentNo AS ParentNum
             , c.APIAccountNo AS APINum
             , c.AAPEffectiveDate AS AAPEff
             , c.AAPQuitDate AS AAPQuit
             , c.APIStatus
             , a.AccountName AS Name
             , a.City
             , a.ST
             , a.Year
             , a.Month
             , a.Total AS APIGRxUnits
             , b.Units AS CAHGRxUnits
        FROM @APITemp AS a
             INNER JOIN @CAHTemp AS b ON a.PMID = b.PMID
                                         AND a.Month = b.Month
                                         AND a.Year = b.YEAR
             INNER JOIN PharmacyMaster.dbo.PM_Pharmacy AS c ON a.PMID = c.PMID;
    END;
GO
