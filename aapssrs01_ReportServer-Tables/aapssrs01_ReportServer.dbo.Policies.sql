USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Policies] Script Date: 12/21/2020 8:07:33 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Policies] (
    [PolicyID]   UNIQUEIDENTIFIER NOT NULL,
    [PolicyFlag] TINYINT          NULL
);


