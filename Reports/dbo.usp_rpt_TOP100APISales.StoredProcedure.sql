USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_rpt_TOP100APISales]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_rpt_TOP100APISales]
AS
SET NOCOUNT ON
SELECT RankBySalesMonth_CurrentMonth
              , NDC_1
              , APIItemNbr_1
              , MonthName_1
              , Qty_1
              , Sales_1
              , APICustomerInvoiceAmount_1
              , RankBySalesMonth_2
              , NDC_2
              , APIItemNbr_2
              , MonthName_2
              , Qty_2
              , Sales_2
              , APICustomerInvoiceAmount_2
              , RankBySalesMonth_3
              , NDC_3
              , APIItemNbr_3
              , MonthName_3
              , Qty_3
              , Sales_3
              , APICustomerInvoiceAmount_3
              , Description
              , Manufacturer
              , PackageSize
FROM [API].dbo.API_Top100_Sales
ORDER BY CASE WHEN RankBySalesMonth_CurrentMonth IS NULL THEN 1 ELSE 0 END, RankBySalesMonth_CurrentMonth
GO
