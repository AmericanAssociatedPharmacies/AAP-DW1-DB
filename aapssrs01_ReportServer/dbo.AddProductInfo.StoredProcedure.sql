USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[AddProductInfo]    Script Date: 12/22/2020 5:44:05 AM ******/
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
GO
