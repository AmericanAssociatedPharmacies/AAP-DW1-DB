USE [IOSDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Inventory_Load]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Inventory_Load]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

		TRUNCATE TABLE [Staging].[Inventory];

		INSERT INTO [Staging].[Inventory](WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, RowversionID, StockTakeListNumber)
		SELECT WarehouseNumber, LocationZone, LocationID, Item, Batch, FirstPutAwayDate, OldestReceptionDate, QuantityInLocation, QuantityReservedForPick, StockTakeStatus, PickPriority, PutAwayPriority, LastStockTakeDate, LocationType, UnusableNonConformingStockOnHandQuantity, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, IsSerialNumberTracking, OrderReferenceNumber, OrderReferenceLineNumber, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDateKey, ETLDate, ETLTime, RowversionID, StockTakeListNumber
		FROM [Staging].[vwInventory]

		UPDATE STATISTICS Staging.Inventory;

		INSERT INTO [dbo].[InventoryDim](WarehouseNumber, WarehouseNUmberDescription, LocationZone, LocationID, LocationType, Item, Batch, FirstPutAwayDate, OldestReceptionDate, StockTakeStatus, IsSerialNumberTracking, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDate, ETLTime, RowversionID, StockTakeListNumber)
		SELECT WarehouseNumber
		, CASE 
			WHEN WarehouseNumber = '1' THEN 'Scottsboro'
			WHEN WarehouseNumber = '2' THEN 'Memphis'
			ELSE NULL
			END AS WarehouseNUmberDescription
		, LocationZone, LocationID, LocationType, Item, Batch, FirstPutAwayDate, OldestReceptionDate, StockTakeStatus
		, IsSerialNumberTracking, LandedCostsRequired, IsQualityControl, IsTransitDelivery, IsHeldBalance, ItemNumber, ETLDate, ETLTime, RowversionID, StockTakeListNumber
		FROM [Staging].[Inventory] AS s
		WHERE NOT EXISTS(SELECT 1
							FROM [dbo].[InventoryDim] AS id
							WHERE s.RowversionID = id.RowversionID		
							)
		
		UPDATE STATISTICS [dbo].[InventoryDim]

		
		INSERT INTO [dbo].[InventoryFact](DateKey, DrugKey, InventoryKey, QuantityInLocation, QuantityReservedForPick, PickPriority, PutAwayPriority, LastStockTakeDate
										, UnusableNonConformingStockOnHandQuantity, UsableNonConformingStockOnHandQuantity, NonConformityCertificateNumber, OrderReferenceNumber
										, OrderReferenceLineNumber, TransactionCount
										)
		select dt.datekey
		, dt.drugkey
		, dt.inventorykey		
		, dt.quantityinlocation
		, dt.quantityreservedforpick
		, dt.pickpriority
		, dt.putawaypriority
		, dt.laststocktakedate
		, dt.unusablenonconformingstockonhandquantity
		, dt.usablenonconformingstockonhandquantity
		, dt.nonconformitycertificatenumber
		, dt.orderreferencenumber
		, dt.orderreferencelinenumber
		, dt.transactioncount
		from(select ROW_NUMBER() OVER(PARTITION BY etldatekey, ISNULL(ISNULL(rx1.drugkey,rx2.drugkey),0), d.inventorykey ORDER BY(SELECT NULL)) AS RN
			, etldatekey as datekey
			, ISNULL(ISNULL(rx1.drugkey,rx2.drugkey),0) as drugkey
			, d.inventorykey		
			, quantityinlocation
			, quantityreservedforpick
			, pickpriority
			, putawaypriority
			, laststocktakedate
			, unusablenonconformingstockonhandquantity
			, usablenonconformingstockonhandquantity
			, nonconformitycertificatenumber
			, orderreferencenumber
			, orderreferencelinenumber
			, 1 as transactioncount
			from [staging].[inventory] as s
			inner join [dbo].[inventorydim] as d on s.rowversionid = d.rowversionid
			left outer join(select distinct ndc, api_itemnumber
								from [pricing].[dbo].[competitordrugdim]
								where api_itemnumber is not null
								) as a on a.api_itemnumber = s.itemnumber
			left outer join(select drugkey
								, ndc
								, startdatekey
								, enddatekey
								from dbo.drugdim
							) as rx1 on a.ndc = rx1.ndc 
											and rx1.startdatekey <= s.etldatekey
											and rx1.enddatekey >= s.etldatekey
			left outer join(select max(drugkey) as drugkey
								, ndc
								from dbo.drugdim
								group by ndc
								) as rx2 on a.ndc = rx2.ndc 			
			) as dt
		WHERE dt.RN = 1
		AND NOT EXISTS(SELECT 1
						FROM dbo.InventoryFact AS i
						WHERE dt.datekey = i.DateKey
						AND dt.drugkey = i.DrugKey
						AND dt.InventoryKey = i.InventoryKey		
							)
		order by dt.datekey asc
			, dt.drugkey asc
		, dt.inventorykey asc	
		--445392

		UPDATE STATISTICS [dbo].[InventoryFact]

END TRY
BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );

	ROLLBACK TRAN

END CATCH
		

END

GO
