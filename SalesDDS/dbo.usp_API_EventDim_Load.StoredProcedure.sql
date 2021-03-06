USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_EventDim_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROCEDURE [dbo].[usp_API_EventDim_Load]

	@DateKey INT


AS

SET NOCOUNT ON;

BEGIN



		
		SELECT dt.EventKey
		, dt.DateKey
		, dt.InvoiceNumber
		, dt.InvoiceLineNumber
		, dt.InvoiceDate
		, dt.TerritoryManagerNumber
		, dt.AccountNumber
		, dt.CustomerReference
		, dt.PMID
		, dt.WarehouseNumber
		, dt.ItemGroupNumber
		, dt.AccountGroupNumber
		, dt.NDCOriginal
		, dt.NDC
		, dt.ItemNumber
		, dt.ItemDescription
		, dt.IsCredit
		, dt.IsOrderFee
		, dt.Type
		, dt.APISalesDetailID
		, dt.RowversionID
		, dt.TransTypeCode
		, dt.TransTypeCodeDesc
		FROM(SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY t.PMID ASC, t.DateKey ASC, t.InvoiceNumber ASC, t.InvoiceLineNumber ASC) + cj.MaxEventKey) AS EventKey 
			, t.DateKey
			, t.InvoiceNumber
			, t.InvoiceLineNumber
			, t.InvoiceDate
			, t.TerritoryManagerNumber
			, t.AccountNumber
			, t.CustomerReference
			, t.PMID
			, t.WarehouseNumber
			, t.ItemGroupNumber
			, t.AccountGroupNumber
			, t.NDCOriginal
			, t.NDC
			, t.ItemNumber
			, t.ItemDescription
			, t.IsCredit
			, t.IsOrderFee
			, t.Type
			, t.APISalesDetailID
			, t.RowversionID
			, t.TransTypeCode
			, t.TransTypeCodeDesc
			FROM Staging.vwEventDimAPI AS t
			CROSS JOIN(SELECT MAX(EventKey) AS MaxEventKey
						FROM dbo.EventDimAPI WITH(NOLOCK)
						) AS cj
			WHERE NOT EXISTS(SELECT 1
								FROM dbo.EventDimAPI AS e WITH(NOLOCK)
								WHERE t.APISalesDetailID = e.APISalesDetailID
								AND t.DateKey = e.DateKey
								)
			AND t.DateKey = @DateKey
			) AS dt 
		ORDER BY dt.EventKey ASC, dt.DateKey ASC

	--	SELECT t.EventKey
	--	, t.DateKey
	--	, t.InvoiceNumber
	--	, t.InvoiceLineNumber
	--	, t.InvoiceDate
	--	, t.TerritoryManagerNumber
	--	, t.AccountNumber
	--	, t.CustomerReference
	--	, t.PMID
	--	, t.WarehouseNumber
	--	, t.ItemGroupNumber
	--	, t.AccountGroupNumber
	--	, t.NDCOriginal
	--	, t.NDC
	--	, t.ItemNumber
	--	, t.ItemDescription
	--	, t.IsCredit
	--	, t.IsOrderFee
	--	, t.Type
	--	, t.APISalesDetailID
	--	, t.RowversionID
	--	FROM(SELECT ISNULL(dt.EventKey, dt2.EventKey) AS EventKey
	--		, ISNULL(dt.DateKey, dt2.DateKey) AS DateKey
	--		, ISNULL(dt.InvoiceNumber, dt2.InvoiceNumber) AS InvoiceNumber
	--		, ISNULL(dt.InvoiceLineNumber, dt2.InvoiceLineNumber) AS InvoiceLineNumber
	--		, ISNULL(dt.InvoiceDate, dt2.InvoiceDate) AS InvoiceDate
	--		, ISNULL(dt.TerritoryManagerNumber, dt2.TerritoryManagerNumber) AS TerritoryManagerNumber
	--		, ISNULL(dt.AccountNumber, dt2.AccountNumber) AS AccountNumber
	--		, ISNULL(dt.CustomerReference, dt2.CustomerReference) AS CustomerReference
	--		, ISNULL(dt.PMID, dt2.PMID) AS PMID
	--		, ISNULL(dt.WharehouseNumber, dt2.WharehouseNumber) AS WarehouseNumber
	--		, ISNULL(dt.ItemGroupNumber, dt2.ItemGroupNumber) AS ItemGroupNumber
	--		, ISNULL(dt.AccountGroupNumber, dt2.AccountGroupNumber) AS AccountGroupNumber
	--		, ISNULL(dt.NDCOriginal, dt2.NDCOriginal) AS NDCOriginal
	--		, ISNULL(dt.NDC, dt2.NDC) AS NDC
	--		, ISNULL(dt.ItemNumber, dt2.ItemNumber) AS ItemNumber
	--		, ISNULL(dt.ItemDescription, dt2.ItemDescription) AS ItemDescription
	--		, ISNULL(dt.IsCredit, dt2.IsCredit) AS IsCredit
	--		, ISNULL(dt.IsOrderFee, dt2.IsOrderFee) AS IsOrderFee
	--		, ISNULL(dt.[Type], dt2.Type) AS [Type]
	--		, ISNULL(dt.RowversionID, dt2.RowversionID) AS RowversionID
	--		, ISNULL(dt.APISalesDetailID, dt2.APISalesDetailID) AS APISalesDetailID
	--		, ISNULL(dt.RowID, dt2.RowID) AS RowID
	--		FROM Staging.vwEventDimAPI AS e
	--		LEFT OUTER JOIN(SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY s.PMID ASC, s.DateKey ASC, s.InvoiceNumber ASC, s.InvoiceLineNumber ASC)) AS EventKey
	--				, s.RowID
	--				, s.DateKey
	--				, s.InvoiceNumber
	--				, s.InvoiceLineNumber
	--				, s.InvoiceDate
	--				, s.TerritoryManagerNumber
	--				, s.AccountNumber
	--				, s.CustomerReference
	--				, s.PMID
	--				, s.WharehouseNumber
	--				, s.ItemGroupNumber
	--				, s.AccountGroupNumber
	--				, s.NDCOriginal
	--				, s.NDC
	--				, s.ItemNumber
	--				, s.ItemDescription
	--				, s.IsCredit
	--				, s.IsOrderFee
	--				, s.[Type]
	--				, s.RowversionID
	--				, s.APISalesDetailID 
	--				FROM Staging.vwEventDimAPI AS s
	--				WHERE s.DateKey = @DateKey
	--				AND NOT EXISTS(SELECT 1
	--								FROM dbo.EventDimAPI AS A
	--								WHERE A.PMID = s.PMID
	--								AND A.DateKey = s.DateKey				
	--								)
	--				) AS dt ON e.RowID = dt.RowID
	--		LEFT OUTER JOIN(SELECT CONVERT(INT, ROW_NUMBER() OVER(ORDER BY s.PMID ASC, s.DateKey ASC, s.InvoiceNumber ASC, s.InvoiceLineNumber ASC) + cj.MaxEventKey) AS EventKey
	--						, s.RowID
	--						, s.DateKey
	--						, s.InvoiceNumber
	--						, s.InvoiceLineNumber
	--						, s.InvoiceDate
	--						, s.TerritoryManagerNumber
	--						, s.AccountNumber
	--						, s.CustomerReference
	--						, s.PMID
	--						, s.WharehouseNumber
	--						, s.ItemGroupNumber
	--						, s.AccountGroupNumber
	--						, s.NDCOriginal
	--						, s.NDC
	--						, s.ItemNumber
	--						, s.ItemDescription
	--						, s.IsCredit
	--						, s.IsOrderFee
	--						, s.[Type]
	--						, s.RowversionID
	--						, s.APISalesDetailID 
	--						FROM Staging.vwEventDimAPI AS s
	--						CROSS JOIN(SELECT MAX(EventKey) AS MaxEventKey
	--										--, PMID
	--										--, DateKey
	--									FROM dbo.EventDimAPI
	--									--WHERE DateKey = @DateKey
	--									--GROUP BY PMID
	--									--, DateKey		
	--										) AS cj
	--						WHERE s.DateKey = @DateKey
	--						--AND cj.DateKey = s.DateKey
	--						--AND s.PMID = cj.PMID
	--						) AS dt2 ON e.RowID = dt2.RowID
	--		WHERE dt.RowID IS NOT NULL 
	--				OR dt2.RowID IS NOT NULL
	--	) AS t
	--WHERE NOT EXISTS(SELECT 1
	--					FROM dbo.EventDimAPI AS a (NOLOCK)
	--					WHERE t.APISalesDetailID = a.APISalesDetailID
	--					AND t.DateKey = a.DateKey
	--					--AND t.RowversionID = a.RowversionIDOnDB1
	--					)
	--ORDER BY t.EventKey ASC, t.DateKey ASC


END











GO
