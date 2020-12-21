USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[UpgradeInfo] Script Date: 12/21/2020 8:11:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UpgradeInfo] (
    [Item]   NVARCHAR (260) NOT NULL,
    [Status] NVARCHAR (512) NULL
);


