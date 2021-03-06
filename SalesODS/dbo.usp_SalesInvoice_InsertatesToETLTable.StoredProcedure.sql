USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesInvoice_InsertatesToETLTable]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SalesInvoice_InsertatesToETLTable]

AS

SET NOCOUNT ON;

BEGIN


	INSERT INTO [dbo].[ETL_SalesInvoice_InvDate](InvDate, IsComplete)
	SELECT InvDate, 0
	FROM [Staging].[SalesInvoice_ETL] AS s
	WHERE NOT EXISTS(SELECT 1
						FROM [dbo].[ETL_SalesInvoice_InvDate] AS si
						WHERE s.InvDate = si.InvDate	
						)


END
GO
