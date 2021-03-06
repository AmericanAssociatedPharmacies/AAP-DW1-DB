USE [IOSDDS]
GO
/****** Object:  View [Staging].[vwInventory]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [Staging].[vwInventory]

AS

SELECT RowID
, CASE	
	WHEN WarehouseNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(WarehouseNumber))
	END AS WarehouseNumber
, CASE	
	WHEN LocationZone NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(LocationZone))
	END AS LocationZone
, CASE	
	WHEN LocationID NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(LocationID))
	END AS LocationID
, CASE	
	WHEN Item NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(Item))
	END AS Item
, CASE	
	WHEN Batch NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(Batch))
	END AS Batch
, FirstPutAwayDate
, OldestReceptionDate
, QuantityInLocation
, QuantityReservedForPick
, CASE	
	WHEN StockTakeStatus NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(StockTakeStatus))
	END AS StockTakeStatus
, PickPriority
, PutAwayPriority
, LastStockTakeDate
, CASE	
	WHEN LocationType NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(LocationType))
	END AS LocationType
, UnusableNonConformingStockOnHandQuantity
, UsableNonConformingStockOnHandQuantity
, NonConformityCertificateNumber
, CASE	
	WHEN [SerialNumberTrackingY/N] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM([SerialNumberTrackingY/N]))
	END AS IsSerialNumberTracking
, OrderReferenceNumber
, OrderReferenceLineNumber
, CASE	
	WHEN LandedCostsRequired NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(LandedCostsRequired))
	END AS LandedCostsRequired
, CASE	
	WHEN [QualityControlY/N] NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM([QualityControlY/N]))
	END AS IsQualityControl
, CASE	
	WHEN [TransitDeliveryY/N]  NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM([TransitDeliveryY/N] ))
	END AS IsTransitDelivery
, CASE	
	WHEN [HeldBalanceY/N]  NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM([HeldBalanceY/N]))
	END AS IsHeldBalance
, CASE	
	WHEN ItemNumber NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE LTRIM(RTRIM(ItemNumber))
	END AS ItemNumber
, ETLDateKey
, ETLDate
, ETLTime
, RowversionID
, StockTakeListNumber
FROM InventoryODS.[Staging].[vwAPIInventory]
GO
