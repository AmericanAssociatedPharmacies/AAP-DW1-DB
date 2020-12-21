USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetCurrentProductInfo] Script Date: 12/21/2020 9:09:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCurrentProductInfo]
AS
    SELECT TOP 1 [DbSchemaHash], [Sku], [BuildNumber]
    FROM [dbo].[ProductInfoHistory]
    ORDER BY DateTime DESC
