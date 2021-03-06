USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_EventDim_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE PROCEDURE [dbo].[usp_CAH_EventDim_Load]

	@DateKey INT


AS

SET NOCOUNT ON;

BEGIN

	SELECT  s.RowID
	, DateKey
	, InvoiceNumber
	, InvoiceLineNumber
	, InvoiceDate
	, PMID
	, DistributionCenter
	, NDC
	, ContractNumber
	, ContractDescription
	, UPC
	, ItemNumber
	, ItemDescription
	, ItemType
	, OrderNumber
	, IsBackupSource
	, IsTenSource
	, IsSourceWeekly
	, IsTopGenerics
	, RowversionID
	, [CHPH_AAP_ID]
	, RowversionID_DB1
	, [CAHAccountNo]
	, [CAHType]
	, [Brand]
	, DEA
	FROM Staging.vwEventDimCAH AS s WITH(NOLOCK)
	WHERE s.DateKey = @DateKey
	AND NOT EXISTS(SELECT 1
					FROM dbo.EventDimCAH AS c WITH(NOLOCK) 
					WHERE s.CHPH_AAP_ID = c.CHPH_AAP_ID
					)

	
	--SELECT ISNULL(dt1.EventKey,dt2.EventKey) AS EventKey
	--, ISNULL(dt1.DateKey, dt2.DateKey) AS DateKey
	--, ISNULL(dt1.InvoiceNumber, dt2.InvoiceNumber) AS InvoiceNumber
	--, ISNULL(dt1.InvoiceLineNumber, dt2.InvoiceLineNumber) AS InvoiceLineNumber
	--, ISNULL(dt1.InvoiceDate, dt2.InvoiceDate) AS InvoiceDate
	--, ISNULL(dt1.PMID, dt2.PMID) AS PMID
	--, ISNULL(dt1.DistributionCenter, dt2.DistributionCenter) AS DistributionCenter
	--, ISNULL(dt1.NDC, dt2.NDC) AS NDC
	--, ISNULL(dt1.ContractNumber, dt2.ContractNumber) AS ConstractNumber
	--, ISNULL(dt1.ContractDescription, dt2.ContractDescription) AS ContractDescription
	--, ISNULL(dt1.UPC, dt2.UPC) AS UPC
	--, ISNULL(dt1.ItemNumber, dt2.ItemNumber) AS ItemNumber
	--, ISNULL(dt1.ItemDescription, dt2.ItemDescription) AS ItemDescription
	--, ISNULL(dt1.ItemType, dt2.ItemType) AS ItemType
	--, ISNULL(dt1.OrderNumber, dt2.OrderNumber) AS OrderNumber
	--, ISNULL(dt1.IsBackupSource, dt2.IsBackupSource) IsBackupSource
	--, ISNULL(dt1.IsTenSource, dt2.IsTenSource) AS IsTenSource
	--, ISNULL(dt1.IsSourceWeekly, dt2.IsSourceWeekly) AS IsSourceWeekly
	--, ISNULL(dt1.IsTopGenerics, dt2.IsTopGenerics) AS IsTopGenerics
	--, ISNULL(dt1.RowversionID, dt2.RowversionID) AS RowversionID
	--, ISNULL(dt1.[CHPH_AAP_ID], dt2.CHPH_AAP_ID) AS CHPH_AAP_ID
	--, ISNULL(dt1.RowversionID_DB1, dt2.RowversionID_DB1) AS RowversionID_DB1
	--FROM Staging.vwEventDimCAH As e WITH(NOLOCK)
	--LEFT OUTER JOIN (SELECT  s.RowID
	--						, DateKey
	--						, InvoiceNumber
	--						, InvoiceLineNumber
	--						, InvoiceDate
	--						, PMID
	--						, DistributionCenter
	--						, NDC
	--						, ContractNumber
	--						, ContractDescription
	--						, UPC
	--						, ItemNumber
	--						, ItemDescription
	--						, ItemType
	--						, OrderNumber
	--						, IsBackupSource
	--						, IsTenSource
	--						, IsSourceWeekly
	--						, IsTopGenerics
	--						, RowversionID
	--						, [CHPH_AAP_ID]
	--						, RowversionID_DB1
	--						FROM Staging.vwEventDimCAH AS s WITH(NOLOCK)
	--						WHERE s.DateKey = @DateKey
	--						AND NOT EXISTS(SELECT 1
	--										FROM dbo.EventDimCAH AS c WITH(NOLOCK) 
	--										WHERE s.CHPH_AAP_ID = c.CHPH_AAP_ID
	--										)
	--				) AS dt1 ON e.RowID = dt1.RowID
	--LEFT OUTER JOIN (SELECT s.RowID
	--				, s.DateKey
	--				, s.InvoiceNumber
	--				, s.InvoiceLineNumber
	--				, s.InvoiceDate
	--				, s.PMID
	--				, s.DistributionCenter
	--				, s.NDC
	--				, s.ContractNumber
	--				, s.ContractDescription
	--				, s.UPC
	--				, s.ItemNumber
	--				, s.ItemDescription
	--				, s.ItemType
	--				, s.OrderNumber
	--				, s.IsBackupSource
	--				, s.IsTenSource
	--				, s.IsSourceWeekly
	--				, s.IsTopGenerics
	--				, s.RowversionID
	--				, s.[CHPH_AAP_ID]
	--				, s.RowversionID_DB1
	--				FROM Staging.vwEventDimCAH AS s WITH(NOLOCK)
	--				CROSS JOIN(SELECT MAX(EventKey) AS MaxEventKey
	--							--, PMID
	--							, DateKey
	--						FROM dbo.EventDimCAH WITH(NOLOCK)
	--						WHERE DateKey = @DateKey
	--						GROUP BY  DateKey		
	--							) AS cj
	--				WHERE s.DateKey = @DateKey
	--				AND cj.DateKey = s.DateKey
	--				--AND s.PMID = cj.PMID
	--			) AS dt2 ON e.RowID = dt2.RowID
	--WHERE dt1.RowID IS NOT NULL
	--OR dt2.RowID IS NOT NULL
	--OPTION(MAXDOP 1) 
	




END











GO
