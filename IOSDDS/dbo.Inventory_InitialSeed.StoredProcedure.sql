USE [IOSDDS]
GO
/****** Object:  StoredProcedure [dbo].[Inventory_InitialSeed]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Inventory_InitialSeed]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DateKey INT

	DECLARE C1 CURSOR FOR
	SELECT DISTINCT [ETLDateKey]
	FROM InventoryODS.[Archive].[APIInventory]
	ORDER BY ETLDateKey ASC

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @DateKey

	DECLARE @EndDateKey INT

	SET @EndDateKey = CAST(CONVERT(varchar(20),DATEADD(DAY, 1 ,CONVERT(datetime, convert(varchar(10), @DateKey))),112) as INT);

	WHILE @@FETCH_STATUS = 0
	BEGIN

		TRUNCATE TABLE Staging.Inventory

		INSERT INTO Staging.Inventory(WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation
		, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity
		, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber
		, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, RowversionID, StockTakeListNumber)
		SELECT WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation
		, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity
		, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber
		, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, RowversionID, StockTakeListNumber
		FROM InventoryODS.[Archive].[vwAPIInventory]
		WHERE ETLDateKey = @DateKey		

		UPDATE STATISTICS Staging.Inventory

		INSERT INTO [dbo].[InventoryDim](WarehouseNumber, WarehouseNUmberDescription, LocationZone, LocationID, LocationType, Item, Batch, FirstPutAwayDate, OldestReceptionDate, StockTakeStatus, IsSerialNumberTracking, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDate, ETLTime, RowversionID, StockTakeListNumber)
		SELECT WarehouseNumber
		, CASE 
			WHEN WarehouseNumber = '1' THEN 'Scottsboro'
			WHEN WarehouseNumber = '2' THEN 'Memphis'
			ELSE NULL
			END AS WarehouseNUmberDescription
		, LocationZone, LocationID, LocationType, Item, Batch, FirstPutAwayDate, OldestReceptionDate, StockTakeStatus
		, IsSerialNumberTracking, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDate, ETLTime, RowversionID, StockTakeListNumber
		FROM(SELECT ROW_NUMBER() OVER(PARTITION BY WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation
									, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity
									, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber
									, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, StockTakeListNumber ORDER BY(SELECT NULL)
									) AS RN
			, RowID, WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation
			, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity
			, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber
			, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, RowversionID, StockTakeListNumber
			FROM [Staging].[Inventory]
			WHERE ETLDateKey = @DateKey
			) AS dt
		WHERE dt.RN = 1 
		ORDER BY ItemNumber ASC, ETLDateKey ASC, ETLTime ASC

		UPDATE STATISTICS [dbo].[InventoryDim]

		
		INSERT INTO [dbo].[InventoryFact](DateKey, DrugKey, InventoryKey, QuantityInLocation, QuantityReservedForPick, PickPriority, PutAwayPriority, LastStockTakeDate
										, UnusableNonConformingStockOnHandQuantity, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, OrderReferenceNumber
										, OrderReferenceLineNumber, TransactionCount
										)
		SELECT dt.DateKey
		, dt.DrugKey
		, dt.InventoryKey		
		, dt.QuantityInLocation
		, dt.QuantityReservedForPick
		, dt.PickPriority
		, dt.PutAwayPriority
		, dt.LastStockTakeDate
		, dt.UnusableNonConformingStockOnHandQuantity
		, dt.UsableNonConformingStockOnHandQuantity
		, dt.NonConformityCertificateNumber
		, dt.OrderReferenceNumber
		, dt.OrderReferenceLineNumber
		, dt.TransactionCount
		FROM(SELECT ETLDateKey AS DateKey
			, ISNULL(ISNULL(rx1.DrugKey,rx2.DrugKey),0) AS DrugKey
			, d.InventoryKey		
			, QuantityInLocation
			, QuantityReservedForPick
			, PickPriority
			, PutAwayPriority
			, LastStockTakeDate
			, UnusableNonConformingStockOnHandQuantity
			, UsableNonConformingStockOnHandQuantity
			, NonConformityCertificateNumber
			, OrderReferenceNumber
			, OrderReferenceLineNumber
			, 1 AS TransactionCount
			FROM [Staging].[Inventory] AS s
			INNER JOIN [dbo].[InventoryDim] AS d ON s.RowversionID = d.RowversionID
			LEFT OUTER JOIN(SELECT DISTINCT NDC, API_ItemNumber
								FROM [Pricing].[dbo].[CompetitorDrugDim]
								WHERE API_ItemNumber IS NOT NULL
								) AS a ON a.API_ItemNumber = s.ItemNumber
			LEFT OUTER JOIN(SELECT DrugKey
								, NDC
								FROM dbo.DrugDim
								WHERE StartDateKey <= @DateKey
								AND EndDateKey >= @EndDateKey
								) AS rx1 ON a.NDC = rx1.NDC 
			LEFT OUTER JOIN(SELECT MAX(DrugKey) AS DrugKey
								, NDC
								FROM dbo.DrugDim
								GROUP BY NDC
								) AS rx2 ON a.NDC = rx2.NDC 
			WHERE s.ETLDateKey = @DateKey
			) AS dt
		ORDER BY dt.DateKey ASC
			, dt.DrugKey ASC
		, dt.InventoryKey ASC	

		UPDATE STATISTICS [dbo].[InventoryFact]

		CHECKPOINT

		DBCC SHRINKFILE(2,1)

		FETCH NEXT
		FROM C1
		INTO @DateKey


	END

	CLOSE C1
	DEALLOCATE C1

END
GO
