USE [ODSIntake]
GO
/****** Object:  View [Staging].[APIOrders_DetailRecord]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[APIOrders_DetailRecord]

AS


SELECT dt.RawOrder
, SUBSTRING(RawOrder, 1,2) AS Flag
, SUBSTRING(RawOrder, 3,1) AS ItemType
, SUBSTRING(RawOrder, 4,20) AS ItemNumber
, SUBSTRING(RawOrder, 24,6) AS QuantityOrdered
, SUBSTRING(RawOrder, 30,5) AS QuantityShipped
, SUBSTRING(RawOrder, 35,1) AS Warehouse
, SUBSTRING(RawOrder, 36,10) AS ItemPrice
, SUBSTRING(RawOrder, 46,2) AS FunctionCode
, SUBSTRING(RawOrder, 48,8) AS EffectiveDate
, SUBSTRING(RawOrder, 56,17) AS Filler
, SUBSTRING(RawOrder, 73,4) AS RecordCounter
, SUBSTRING(RawOrder, 77,4) AS ConfirmationNumber
FROM(SELECT RawOrder
	, SUBSTRING(RawOrder, 1,2) AS Flag
	FROM Staging.RawOrder
	) AS dt
WHERE dt.Flag = 'U6'
GO
