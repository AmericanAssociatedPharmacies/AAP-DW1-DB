USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimCAH_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_EventDimCAH_Update]

	@DateKey INT


AS


SET NOCOUNT ON;

BEGIN

	UPDATE x
	SET InvoiceNumber = c.InvoiceNumber
	, InvoiceLineNumber = c.InvoiceLineNumber
	, InvoiceDate = c.InvoiceDate
	, PMID = c.PMID
	, DistributionCenter = c.DistributionCenter
	, NDC = c.NDC
	, UPC = c.UPC
	, ItemNumber = c.ItemNumber
	, ItemDescription = c.ItemDescription
	, ItemType = c.ItemType
	, OrderNumber = c.OrderNumber
	, IsBackupSource = c.IsBackupSource
	, IsTenSource = c.IsTenSource
	, IsSourceWeekly = c.IsSourceWeekly
	, IsTopGenerics = c.IsTopGenerics
	, RowversionID_DB1 = c.RowversionID_DB1
	, [CAHType] = c.[CAHType]
	,  [Brand] = c.[Brand]
	, DEA = c.DEA
	OUTPUT INSERTED.EventKey,INSERTED.DateKey
	INTO dbo.EventDimCAH_AfterUpdate(EventKey,DateKey)
	FROM [dbo].[EventDimCAH] AS x
	INNER JOIN Staging.vwEventDimCAH AS c ON x.CHPH_AAP_ID = c.CHPH_AAP_ID
									AND x.DateKey = c.DateKey
	WHERE x.DateKey = @DateKey
	AND c.DateKey = @DateKey

END



								


GO
