USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIInventoryV1_0_0_T]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author: David Bohler
-- Create date: 10/24/2017
-- Description: API Inventory Report 
/*
Date Filter Defualt 2 weeks 
API item filter 
Description filter 
Warehouse Filter
*/

-- =============================================
CREATE PROCEDURE [dbo].[usp_APIInventoryV1_0_0_T] 

	@APIItemNum      VARCHAR(14) = NULL,
    @ItemDescription VARCHAR(50) = NULL,
    @Warehouse       VARCHAR(10) = NULL


AS

SET NOCOUNT ON;

BEGIN
    SELECT dt.ItemNumber
	, dt.ItemDescription
	, dt.ETLDateKey
	, dt.RunTime
	, dt.WarehouseNumber
	, SUM(dt.QuantityInLocation) AS TotalInv
    FROM(SELECT iv.WarehouseNumber
		, iv.Item AS ItemDescription
		, iv.QuantityInLocation
		, iv.LocationID
		, iV.ItemNumber
		, iv.ETLDateKey
		, LEFT(iv.ETLTime, 5) AS RunTime
			FROM InventoryODS.dbo.API_Inventory AS iv
			WHERE iv.ItemNumber = ISNULL(@APIItemNum, iv.ItemNumber)
			AND iv.Item LIKE ISNULL(CONCAT('%', @ItemDescription, '%'), iv.Item)
			AND iv.WarehouseNumber = ISNULL(@Warehouse, iv.WarehouseNumber)
		) AS dt
    WHERE dt.RunTime = '15:00'
    GROUP BY dt.ItemNumber
	, dt.ItemDescription
	, dt.ETLDateKey
	, dt.RunTime
	, dt.WarehouseNumber
    ORDER BY dt.ETLDateKey ASC
	, dt.ItemDescription;
END;
GO
