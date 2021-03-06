USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_Order_SalesDetal_XRef_GetMaxSalesOrderID]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Order_SalesDetal_XRef_GetMaxSalesOrderID]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.[MaxSalesDetailID], dt.[MaxOrderID]
	FROM(SELECT MAX(SalesDetailID) AS MaxSalesDetailID
	           ,MAX(OrderID) AS MaxOrderID
			FROM [API].[dbo].[Order_SalesDetal_XRef]
		) AS dt

END
GO
