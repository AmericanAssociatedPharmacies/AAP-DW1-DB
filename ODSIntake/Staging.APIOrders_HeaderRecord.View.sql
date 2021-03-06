USE [ODSIntake]
GO
/****** Object:  View [Staging].[APIOrders_HeaderRecord]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[APIOrders_HeaderRecord]

AS

SELECT dt.RawOrder
, SUBSTRING(RawOrder, 1,2) AS Flag
, SUBSTRING(RawOrder, 3,8) AS CustomerNumber
, SUBSTRING(RawOrder, 11,30) AS PurchaseOrder
, SUBSTRING(RawOrder, 41,2) AS FunctionCode
, SUBSTRING(RawOrder, 43,8) AS EffectiveDate
, SUBSTRING(RawOrder, 51,2) AS RecieverPortNo
, SUBSTRING(RawOrder, 53,6) AS TimeReceived
, SUBSTRING(RawOrder, 59,1) AS StatusCode
, SUBSTRING(RawOrder, 60,1) AS TransType
, SUBSTRING(RawOrder, 61,6) AS DateOrderReceived
, SUBSTRING(RawOrder, 67,6) AS Filler
, SUBSTRING(RawOrder, 73,4) AS RecordCounter
, SUBSTRING(RawOrder, 77,4) AS ConfirmationNumber
FROM(SELECT LTRIM(RTRIM(RawOrder)) AS RawOrder
	, SUBSTRING(LTRIM(RTRIM(RawOrder)), 1,2) AS Flag
	FROM Staging.RawOrder
	) AS dt
WHERE dt.Flag = 'U5'
GO
