USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesInvoice_Web_Load]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[usp_APISalesInvoice_Web_Load]

AS

SET NOCOUNT ON;

BEGIN

MERGE [dbo].[APISalesInvoice_Web] AS T 
USING (SELECT [WHAccountid], [InvNbr], [InvDate], [OrderNbr], [CarrierCode], [CarrierDesc], [Whsnum], [Whsname]
	   FROM [Staging].[APISalesInvoice_Web]) AS S 
	   ([WHAccountid], [InvNbr], [InvDate], [OrderNbr], [CarrierCode], [CarrierDesc], [Whsnum], [Whsname])
	   ON T.[OrderNbr] = S.[OrderNbr]
	   AND T.[InvNbr] = S.[InvNbr]

WHEN MATCHED THEN

UPDATE SET [WHAccountid] = S.[WHAccountid]
		 , [InvDate] = S.[InvDate]
		 , [CarrierCode] = S.[CarrierCode]
		 , [CarrierDesc] = S.[CarrierDesc]
		 , [Whsnum] = S.[Whsnum]
		 , [Whsname] = S.[Whsname]

WHEN NOT MATCHED THEN

	INSERT ([WHAccountid], [InvNbr], [InvDate], [OrderNbr], [CarrierCode], [CarrierDesc], [Whsnum], [Whsname])
	VALUES (S.[WHAccountid], S.[InvNbr], S.[InvDate], S.[OrderNbr], S.[CarrierCode], S.[CarrierDesc], S.[Whsnum], S.[Whsname]);

END
		   


GO
