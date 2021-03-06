USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesInsert_InsertArchiveTable]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_SalesInsert_InsertArchiveTable]

AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO [Archive].[APISalesInvoice](InvNbr, OrderNbr, InvDate, WHAccountID, CustomerName, CarrierCode, CarrierDesc
											, CustomerRef, Whsnum, OrdType, DateLoaded, RowCreatedDateETL
											)
	SELECT InvNbr, OrderNbr, InvDate, WHAccountID, CustomerName, CarrierCode, CarrierDesc
	, CustomerRef, Whsnum, OrdType, DateLoaded, RowCreatedDateETL
	FROM [Staging].[APISalesInvoice] AS sd
	WHERE NOT EXISTS(SELECT 1
						FROM [Archive].[APISalesInvoice] AS ad
						WHERE sd.InvNbr = ad.InvNbr						
						)



END



GO
