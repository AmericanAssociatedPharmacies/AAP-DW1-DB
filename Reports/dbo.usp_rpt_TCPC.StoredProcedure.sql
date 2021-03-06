USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_TCPC]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_rpt_TCPC]
@DateParam DATETIME
AS
SET NOCOUNT ON;
DECLARE @MaxDateKey INT
, @Previous1stDOM DATETIME
, @PreviousLastDOM DATETIME
, @Date INT

 
       select @Previous1stDOM = DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0) --First day of previous month
       select @PreviousLastDOM = DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, 0)
 
       --Get the MAX DateKey
       SELECT @MaxDateKey = MAX(DateKey)
       FROM [Pricing].dbo.PriceFact
       WHERE CardinalInvoicePrice is not null AND ABCInvoicePrice is not null AND APICustomerInvoicePrice is not null
 
       SET @Date = ISNULL(CAST(CONVERT(VARCHAR(8), @DateParam, 112) AS INT), @MaxDateKey)
 
       --Create temp table
       CREATE TABLE #T (GPPC VARCHAR(25)
                                  , GPI VARCHAR(25)
                                  , Description VARCHAR(100)
                                  , PackageSize DECIMAL(9,5)
                                  , CAHContractType VARCHAR(25)
                                  , CAHItemNumber VARCHAR(25)
                                  , CardinalInvoicePrice MONEY
                                  , API_ItemNumber VARCHAR(25)
                                  , APICustomerInvoicePrice MONEY
                                  , ABCItemNumber VARCHAR(25)
                                  , ABCInvoicePrice MONEY
								  , McKessonItemNumber VARCHAR(25)
                                  , McKessonInvoicePrice MONEY
                                  , CAHNADACPrice MONEY
                                  , APINADACPrice MONEY
                                  , ABCNADACPrice MONEY
                                  , CAHRank INT
                                  , ABCRank INT
                                  , APIRank INT
								  , McKessonRank INT
                                  )
       
       --This is a CAH centric report. This is the anchor data point. Insert CAH data into temp table
       INSERT INTO #T(GPPC
       , GPI
       , Description
       , PackageSize
       , CAHItemNumber
       , CAHContractType
       , CardinalInvoicePrice
       , CAHNADACPrice
       , CAHRank
       )
       SELECT DISTINCT dd.GPPC
       , dd.GPI
       , dd.Description --LA 12/6
       , dd.PackageSize AS CAHPackSize
       , cdd.CAHItemNumber
       , cdd.CAHContractType
       , pf.[CardinalInvoicePrice]
       , pf.NADACPrice as CAHNADACPrice
       , RANK() OVER(PARTITION BY dd.GPI, dd.PackageSize ORDER BY min(CardinalInvoicePrice) ASC) AS CAHRank 
       FROM [Pricing].dbo.PriceFact AS pf 
       INNER JOIN [Pricing].dbo.DrugDim AS dd ON dd.DrugKey = pf.DrugKey
       INNER JOIN [Pricing].dbo.CompetitorDrugDim AS cdd ON pf.CompetitorDrugKey = cdd.CompetitorDrugKey
       WHERE pf.DateKey = @Date
       AND [CAHContractType] IN('AAP SOURCE', 'AAP SOURCE BACKUP', 'AAP TOP-GENERICS SOURCE', 'PSB EXCLUDED')
       AND pf.CardinalInvoicePrice IS NOT NULL
       GROUP BY dd.GPPC
       , dd.GPI
       , dd.Description
       , dd.PackageSize 
       , cdd.CAHItemNumber
       , cdd.CAHContractType
       , [CardinalInvoicePrice] 
       , pf.NADACPrice;
 
 
       --Update temp table with ABC data
       UPDATE #T
       SET ABCItemNumber = abc.ABCItemNumber
       , ABCInvoicePrice = abc.ABCInvoicePrice
       , ABCRank = abc.ABCRank
       , ABCNADACPrice = abc.ABC_NADACPrice
       FROM #T AS x
       INNER JOIN(SELECT dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize AS ABCPackSize  
                    , cdd.ABCItemNumber
                    , pf.ABCInvoicePrice
                    , pf.NADACPrice as ABC_NADACPrice
                    , RANK() OVER(PARTITION BY dd.GPI, dd.PackageSize ORDER BY min(ABCInvoicePrice) ASC) AS ABCRank 
                FROM [Pricing].dbo.PriceFact AS pf 
                INNER JOIN [Pricing].dbo.DrugDim AS dd ON dd.DrugKey = pf.DrugKey
                INNER JOIN [Pricing].dbo.CompetitorDrugDim AS cdd ON pf.CompetitorDrugKey = cdd.CompetitorDrugKey
                WHERE pf.DateKey = @Date
                    AND pf.ABCInvoicePrice IS NOT NULL
                GROUP BY dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize 
                    , cdd.ABCItemNumber
                    , pf.ABCInvoicePrice
                    , pf.NADACPrice
                ) AS abc ON x.GPI = abc.GPI 
                                    AND x.PackageSize = abc.ABCPackSize
                                    AND x.CAHRank = abc.ABCRank ;
                                                              
              
 
       --Update temp table with API data
       UPDATE #T
       SET API_ItemNumber = api.API_ItemNumber
       , APICustomerInvoicePrice = API.APICustomerInvoicePrice
       , APIRank = api.APIRank
       , APINADACPrice = api.API_NADACPrice
       FROM #T AS x
       INNER JOIN(SELECT DISTINCT dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize AS APIPackSize
                    , cdd.API_ItemNumber AS API_ItemNumber
                    , pf.APICustomerInvoicePrice
                    , pf.NADACPrice as API_NADACPrice
                    ,RANK() OVER(PARTITION BY dd.GPI, dd.PackageSize ORDER BY min(APICustomerInvoicePrice) ASC) AS APIRank
                FROM [Pricing].dbo.PriceFact AS pf 
                INNER JOIN [Pricing].dbo.DrugDim AS dd ON dd.DrugKey = pf.DrugKey
                INNER JOIN [Pricing].dbo.CompetitorDrugDim AS cdd ON cdd.CompetitorDrugKey = pf.CompetitorDrugKey
                WHERE pf.DateKey = @Date and APICustomerInvoicePrice IS NOT NULL 
                GROUP BY dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize 
                    , cdd.API_ItemNumber 
                    , pf.APICustomerInvoicePrice 
                    , pf.NADACPrice                  
                ) AS api ON x.GPI = api.GPI AND x.CAHRank = api.APIRank AND x.PackageSize = api.APIPackSize;


		--Update temp table with McKesson data
       UPDATE #T
       SET McKessonItemNumber = mck.McKessonItemNumber
       , McKessonInvoicePrice = mck.McKesson
       , McKessonRank = mck.McKessonRank
       FROM #T AS x
       INNER JOIN(SELECT DISTINCT dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize AS McKessonPackSize
                    , cdd.McKessonItemNumber AS McKessonItemNumber
                    , pf.McKesson
                    ,RANK() OVER(PARTITION BY dd.GPI, dd.PackageSize ORDER BY min(McKesson) ASC) AS McKessonRank
                FROM [Pricing].dbo.PriceFact AS pf 
                INNER JOIN [Pricing].dbo.DrugDim AS dd ON dd.DrugKey = pf.DrugKey
                INNER JOIN [Pricing].dbo.CompetitorDrugDim AS cdd ON cdd.CompetitorDrugKey = pf.CompetitorDrugKey
                WHERE pf.DateKey = @Date and McKesson IS NOT NULL 
                GROUP BY dd.GPPC
                    , dd.GPI 
                    , dd.PackageSize 
                    , cdd.McKessonItemNumber 
                    , pf.McKesson                 
                ) AS mck ON x.GPI = mck.GPI AND x.CAHRank = mck.McKessonRank AND x.PackageSize = mck.McKessonPackSize;
 
 
       --CTE used for other CTE's
       ;WITH BaseTable AS (
              SELECT DISTINCT GPPC
              , GPI
              , Description
              , PackageSize AS Size
              , [CAHContractType]
              , CAHItemNumber
              , CardinalInvoicePrice
              , API_ItemNumber
              , APICustomerInvoicePrice
              , MAX(ABCItemNumber) as ABCItemNumber
              , ABCInvoicePrice
			  , MAX(McKessonItemNumber) as McKessonItemNumber
			  , McKessonInvoicePrice
              , CAHRank
              , ABCRank
              , APIRank
			  , McKessonRank
              , CAHNADACPrice
              , APINADACPrice
              , ABCNADACPrice
              FROM #T              
              GROUP BY GPPC
              , GPI
              , [Description]
              , PackageSize 
              , [CAHContractType]
              , CAHItemNumber
              , CardinalInvoicePrice
              , API_ItemNumber
              , APICustomerInvoicePrice
              , ABCInvoicePrice
			  , McKessonInvoicePrice
              , CAHRank 
              , ABCRank 
              , APIRank
			  , McKessonRank
              , CAHNADACPrice
              , APINADACPrice
              , ABCNADACPrice
              
       ),
       /*
       Gets max ABCInvoicePrice per GPPC. 
       Purpose is to populate NULL ABCInvoicePrices with the max ABCInvoicePrice.
       Example, if there are 3 CAHItems and 2 ABCItems, the 3rd ranked CAHItem will be matched with the max ABCItem price
       */
       ABC_Ref AS (
 
              SELECT DISTINCT b1.GPPC, b1.GPI, b1.SIZE, b2.ABCItemNumber, b1.ABCRank, b2.ABCInvoicePrice
              FROM (SELECT GPPC, GPI, SIZE, max(ABCRank) AS ABCRank
                           FROM BaseTable
                           GROUP BY GPPC, GPI, SIZE) AS b1 
              INNER JOIN BaseTable AS b2 ON b1.GPPC = b2.GPPC AND b1.GPI = b2.GPI AND b1.Size = b2.Size AND b1.ABCRank = b2.ABCRank
              
       ),

	   /*
       Gets max McKessonInvoicePrice per GPPC. 
       Purpose is to populate NULL McKessonInvoicePrice with the max McKessonInvoicePrice.
       Example, if there are 3 CAHItems and 2 McKesson Items, the 3rd ranked CAHItem will be matched with the max McKesson price
       */
       McKesson_Ref AS (
 
              SELECT DISTINCT b1.GPPC, b1.GPI, b1.SIZE, b2.McKessonItemNumber, b1.MckessonRank, b2.McKessonInvoicePrice
              FROM (SELECT GPPC, GPI, SIZE, max(McKessonRank) AS McKessonRank
                           FROM BaseTable
                           GROUP BY GPPC, GPI, SIZE) AS b1 
              INNER JOIN BaseTable AS b2 ON b1.GPPC = b2.GPPC AND b1.GPI = b2.GPI AND b1.Size = b2.Size AND b1.McKessonRank = b2.McKessonRank
              
       ),
 
       /*
       Joins CAH, API, and ABC items and prices. 
       Uses ABC_Ref CTE to populate NULL ABC Item Prices
       */
       ItemsAndPRices AS (
 
              SELECT b1.GPPC
                     , b1.GPI
                     , b1.Description
                     , b1.Size
                     , b1.CAHContractType
                     , b1.CAHItemNumber
                     , b1.CardinalInvoicePrice
                     , b1.API_ItemNumber
                     , b1.APICustomerInvoicePrice
                     , ISNULL(b1.ABCItemNumber, b2.ABCItemNumber) AS ABCItemNumber
                     , ISNULL(b1.ABCInvoicePrice, b2.ABCInvoicePrice) AS ABCInvoicePrice
					 , ISNULL(b1.McKessonItemNumber, b3.McKessonItemNumber) AS McKessonItemNumber
                     , ISNULL(b1.McKessonInvoicePrice, b3.McKessonInvoicePrice) AS McKessonInvoicePrice
                     , CAHNADACPrice
                     , APINADACPrice
                     , ABCNADACPrice
              FROM BaseTable b1
              LEFT JOIN ABC_Ref b2
              ON b1.GPPC = b2.GPPC AND b1.GPI = b2.GPI AND b1.Size = b2.Size
			  LEFT JOIN McKesson_Ref b3
              ON b1.GPPC = b3.GPPC AND b1.GPI = b3.GPI AND b1.Size = b3.Size
              
       ),
 
       --Get API Qtys from previous month from Sales Detail table
       API_Sales AS (
              SELECT APIItemNbr
                     , SUM(Qty) as APIQty
              FROM [API]..APISalesDetail
              WHERE Type = 'Generic' AND InvDate >= @Previous1stDOM AND InvDate < @PreviousLastDOM
              GROUP BY APIItemNbr
       ), 
 
       --Get CAH Qtys from previous month from Sales Detail table
       CAH_Sales AS (
              SELECT ITEM_NO
                     , SUM(SHIP_QTY) as CAHQty
              FROM [Purchases]..CHPH_AAP
              WHERE ContractDesc IN ('AAP SOURCE', 'AAP SOURCE BACKUP', 'AAP TOP-GENERICS SOURCE', 'PSB EXCLUDED')
                     AND Inv_Date >= @Previous1stDOM AND Inv_Date < @PreviousLastDOM
              GROUP BY ITEM_NO
       )
 
       --Final Select Statement
       --Populates final report with CAH, API, and ABC items and prices,
       --then join in API and CAH Qtys by ItemNumber
       --SELECT ip.GPPC
       --     , ip.GPI
       --     , ip.Description
       --     , ip.Size
       --     , ip.CAHContractType
       --     , ip.CAHItemNumber
       --     , ip.CardinalInvoicePrice
       --     , ip.API_ItemNumber
       --     , ip.APICustomerInvoicePrice
       --     , ip.ABCItemNumber
       --     , ip.ABCInvoicePrice
       --     , ip.CAHNADACPrice
       --     , ip.APINADACPrice
       --     , ip.ABCNADACPrice
       --     , a.APIQty
       --     , c.CAHQty
 
       SELECT DISTINCT
              ip.GPI
              , ip.Description
              , ip.Size
              , ip.CAHContractType
              , ip.CAHItemNumber
              , ip.CardinalInvoicePrice
              , ip.API_ItemNumber
              , ip.APICustomerInvoicePrice
              , ip.ABCItemNumber
              , ip.ABCInvoicePrice
			  , ip.McKessonItemNumber
			  , ip.McKessonInvoicePrice
              , ip.CAHNADACPrice
              , ip.APINADACPrice
              , ip.ABCNADACPrice
              , a.APIQty
              , c.CAHQty
       FROM ItemsAndPRices ip
       LEFT JOIN API_Sales AS a ON ip.API_ItemNumber = a.APIItemNbr
       LEFT JOIN CAH_Sales AS c ON ip.CAHItemNumber = c.ITEM_NO
       --WHERE ABCItemNumber IS NOT NULL OR API_ItemNumber IS NOT NULL
       --AND GPI = '23100030004030' AND Size = 1
       ORDER BY GPI, Size, CardinalInvoicePrice ASC
       --Pre DISTINCT row count: 11695
RETURN 0
GO
