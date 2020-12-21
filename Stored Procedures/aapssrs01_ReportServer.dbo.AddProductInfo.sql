USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[AddProductInfo] Script Date: 12/21/2020 8:27:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddProductInfo]
    @DbSchemaHash varchar(128),
    @Sku varchar(25),
    @BuildNumber varchar(25)
AS
    INSERT INTO [dbo].[ProductInfoHistory]
        ([DbSchemaHash], [Sku], [BuildNumber])
    VALUES
        (@DbSchemaHash, @Sku, @BuildNumber)
