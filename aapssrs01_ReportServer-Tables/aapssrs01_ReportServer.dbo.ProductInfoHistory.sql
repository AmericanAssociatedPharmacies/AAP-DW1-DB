USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ProductInfoHistory] Script Date: 12/21/2020 8:07:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductInfoHistory] (
    [DateTime]     DATETIME      NULL,
    [DbSchemaHash] VARCHAR (128) NOT NULL,
    [Sku]          VARCHAR (25)  NOT NULL,
    [BuildNumber]  VARCHAR (25)  NOT NULL
);


