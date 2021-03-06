USE [InventoryODS]
GO
/****** Object:  View [Staging].[vwAPIInventory]    Script Date: 12/22/2020 7:02:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Staging].[vwAPIInventory]

AS

SELECT RowID
, LPSROM AS WarehouseNumber
, LPLZON AS LocationZone
, LPLCID AS LocationID
, LPPRDC AS Item
, LPBATC AS Batch
, CONVERT(DATE, CONVERT(VARCHAR, 
				CASE
				WHEN LPFPUT = '0' THEN NULL
				ELSE LPFPUT
				END
				)) AS FirstPutAwayDate
, CONVERT(DATE, CONVERT(VARCHAR, 
				CASE
				WHEN LPLPUT = '0' THEN NULL
				ELSE LPLPUT
				END
				)) AS OldestReceptionDate
, LPLOQT AS QuantityInLocation
, LPPIQT AS QuantityReservedForPick
, LPSTTC  AS StockTakeStatus
, LPLIST  AS StockTakeListNumber
, LPPIPR  AS PickPriority
, LPPUPR  AS PutAwayPriority
, LPSDAT  AS LastStockTakeDate
, LPLOCT   AS LocationType
, LPRQNC AS UnusableNonConformingStockOnHandQuantity
, LPUQNC  AS UsableNonConformingStockOnHandQuantity
, LPNCCN   AS NonConformityCertificateNumber
, LPSENC AS [SerialNumberTrackingY/N]
, LPORFN   AS OrderReferenceNumber
, LPORFL   AS OrderReferenceLineNumber
, LPLCRE  AS LandedCostsRequired
, LPQCYN   AS [QualityControlY/N]
, LPTDCD   AS [TransitDeliveryY/N]
, LPHLBA   AS [HeldBalanceY/N]
, SUBSTRING(LTRIM(RTRIM(LPPRDC)), 1 ,6) AS ItemNumber
, RowCreatedDate
, ETLDateKey
, ETLDate
, ETLTime
, RowVersionID
 FROM [Staging].[APIInventory]




GO
