USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimCAH_Reload]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_EventDimCAH_Reload]

	@DateKey INT

AS 

SET NOCOUNT ON;

BEGIN

	SELECT EventKey, DateKey, InvoiceNumber, InvoiceLineNumber, InvoiceDate, PMID, DistributionCenter, NDC, UPC, ItemNumber, ItemDescription, ItemType, OrderNumber, IsBackupSource, IsTenSource, IsSourceWeekly, IsTopGenerics, RowversionID, RowCreatedDate, CHPH_AAP_ID, RowversionID_DB1, RowUpdatedDate, CAHAccountNo, AccountName, CAHType, Brand
	FROM [dbo].[EventDimCAH_old_RSE_20200715] NOLOCK
	WHERE DateKey = @DateKey
	AND DateKey > 0
END
GO
