USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Staging_CAH_InvoiceLineNumber]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Staging_CAH_InvoiceLineNumber]

	@Date DATETIME

AS

SET NOCOUNT ON;

BEGIN


	UPDATE [Staging].[CHPH_AAP]
	SET InvoiceLineNumber = dt.InvoiceLineNumber
	FROM [Staging].[CHPH_AAP] AS x
	INNER JOIN(SELECT ID
					--, [INVOICE_NO]
					--, [INV_DATE]
					--, [ITEM_NO]
					, CONVERT(INT, ROW_NUMBER() OVER(PARTITION BY PMID, [INVOICE_NO], [INV_DATE] ORDER BY (SELECT NULL))) AS InvoiceLineNumber
					FROM [Staging].[CHPH_AAP]
					WHERE [INV_DATE] = @Date
				) AS dt ON x.ID = dt.ID




END
GO
