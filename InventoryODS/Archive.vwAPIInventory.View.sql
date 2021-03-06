USE [InventoryODS]
GO
/****** Object:  View [Archive].[vwAPIInventory]    Script Date: 12/22/2020 7:02:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [Archive].[vwAPIInventory]

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
, LPSENC AS IsSerialNumberTracking
, LPORFN   AS OrderReferenceNumber
, LPORFL   AS OrderReferenceLineNumber
, LPLCRE  AS LandedCostsRequired
, LPQCYN   AS IsQualityControl
, LPTDCD   AS IsTransitDelivery
, LPHLBA   AS IsHeldBalance
, SUBSTRING(LTRIM(RTRIM(LPPRDC)), 1 ,6) AS ItemNumber
, ETLDateKey
, ETLDate
, ETLTime
, RowversionID
 FROM [Archive].[APIInventory]




GO
