USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[DBUpgradeHistory] Script Date: 12/21/2020 8:03:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DBUpgradeHistory] (
    [UpgradeID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [DbVersion] NVARCHAR (25)  NULL,
    [User]      NVARCHAR (128) NULL,
    [DateTime]  DATETIME       NULL
);


