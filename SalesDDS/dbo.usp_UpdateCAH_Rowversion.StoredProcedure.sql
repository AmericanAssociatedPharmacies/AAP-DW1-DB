USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_UpdateCAH_Rowversion]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_UpdateCAH_Rowversion]

	@Date DATETIME


AS

SET NOCOUNT ON;

BEGIN


	UPDATE [dbo].[EventDim]
	SET CAHRowVersionID = s.RowversionID
	FROM [dbo].[EventDim] AS x
	INNER JOIN [Staging].[CHPH_AAP] AS s ON x.CAH_PMID = s.PMID
											AND x.CAHInvoiceNumber = s.INVOICE_NO
											AND x.CAHInvoiceDate = s.INV_DATE
	WHERE x.CAHInvoiceDate = @Date
	AND s.INV_DATE = @Date

END
GO
