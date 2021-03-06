USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_TOP100CAHUnits]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_rpt_TOP100CAHUnits]
AS
     SET NOCOUNT ON;
     SELECT [RankByVolMonth_CurrentMonth]
          , [NDC_1]
          , [CIN_1]
          , [MonthName_1]
          , [Qty_1]
          , [Sales_1]
          , [CAHCustomerInvoiceAmount_1]
          , [CAHContractType_1]
          , [RankByVolMonth_2]
          , [NDC_2]
          , [CIN_2]
          , [MonthName_2]
          , [Qty_2]
          , [Sales_2]
          , [CAHCustomerInvoiceAmount_2]
          , [CAHContractType_2]
          , [RankByVolMonth_3]
          , [NDC_3]
          , [CIN_3]
          , [MonthName_3]
          , [Qty_3]
          , [Sales_3]
          , [CAHCustomerInvoiceAmount_3]
          , [CAHContractType_3]
          , [Description]
          , [Vendor]
          , [PackageSize]
          , [RowCreatedDate]
          , [RowID]
     FROM [Purchases].dbo.CAH_Top100_Vol
     ORDER BY CASE
                  WHEN [RankByVolMonth_CurrentMonth] IS NULL
                  THEN 1
                  ELSE 0
              END
            , [RankByVolMonth_CurrentMonth];
GO
