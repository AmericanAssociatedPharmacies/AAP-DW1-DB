USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_TOP100APIUnits]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_TOP100APIUnits]
AS
     SET NOCOUNT ON;
         SELECT [RankByVolMonth_CurrentMonth]
              , [NDC_1]
              , [APIItemNbr_1]
              , [MonthName_1]
              , [Qty_1]
              , [Sales_1]
              , [APICustomerInvoiceAmount_1]
              , [RankByVolMonth_2]
              , [NDC_2]
              , [APIItemNbr_2]
              , [MonthName_2]
              , [Qty_2]
              , [Sales_2]
              , [APICustomerInvoiceAmount_2]
              , [RankByVolMonth_3]
              , [NDC_3]
              , [APIItemNbr_3]
              , [MonthName_3]
              , [Qty_3]
              , [Sales_3]
              , [APICustomerInvoiceAmount_3]
              , [Description]
              , [Manufacturer]
              , [PackageSize]
		 FROM [API].dbo.API_Top100_Vol
	    ORDER BY CASE WHEN [RankByVolMonth_CurrentMonth] IS NULL THEN 1 ELSE 0 END, [RankByVolMonth_CurrentMonth]
GO
