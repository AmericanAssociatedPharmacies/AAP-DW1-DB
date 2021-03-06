USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesInvoice_Insert]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_APISalesInvoice_Insert]


AS


SET NOCOUNT ON;

BEGIN

	SET IDENTITY_INSERT API.[dbo].[APISalesInvoice] ON;


	INSERT INTO API.[dbo].[APISalesInvoice](ID, InvNbr, OrderNbr, InvDate, WHAccountID, CustomerName, CarrierCode, CarrierDesc, CustomerRef, Whsnum, OrdType, DateLoaded)
	SELECT ID, InvNbr, OrderNbr, InvDate, WHAccountID, CustomerName, CarrierCode, CarrierDesc, CustomerRef, Whsnum, OrdType, DateLoaded
	FROM [Staging].[APISalesInvoice] AS s
	WHERE NOT EXISTS(SELECT 1
						FROM API.[dbo].[APISalesInvoice] AS sa
						WHERE s.ID = sa.ID
						)

	SET IDENTITY_INSERT API.[dbo].[APISalesInvoice] OFF;


END
GO
