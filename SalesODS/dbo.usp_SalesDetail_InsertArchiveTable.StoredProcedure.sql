USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesDetail_InsertArchiveTable]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_SalesDetail_InsertArchiveTable]

AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO [Archive].[APISalesDetail](ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
											, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded
											, Type, WHNbr, Rebate, RowCreatedDateETL
											)
	SELECT ID, WHAccountID, InvNbr, InvLine, CustomerName, APIItemNbr, ItemDescription, Qty, UnitAmount, ItemGrp
	, AcctGrp, Territory, InvDate, LineAmt, ExtSales, OrderNbr, NDC_orig, NDC, DateLoaded, Type, WHNbr, Rebate, RowCreatedDateETL
	FROM [Staging].[APISalesDetail] AS sd
	WHERE NOT EXISTS(SELECT 1
						FROM [Archive].[APISalesDetail] AS ad
						WHERE sd.InvNbr = ad.InvNbr
						AND sd.InvLine = ad.InvLine
						)



END




GO
