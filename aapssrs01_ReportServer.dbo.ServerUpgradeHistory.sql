USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ServerUpgradeHistory] Script Date: 12/21/2020 8:10:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ServerUpgradeHistory] (
    [UpgradeID]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [ServerVersion] NVARCHAR (25)  NULL,
    [User]          NVARCHAR (128) NULL,
    [DateTime]      DATETIME       NULL
);


