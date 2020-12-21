USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Keys] Script Date: 12/21/2020 8:04:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Keys] (
    [MachineName]    NVARCHAR (256)   NULL,
    [InstallationID] UNIQUEIDENTIFIER NOT NULL,
    [InstanceName]   NVARCHAR (32)    NULL,
    [Client]         INT              NOT NULL,
    [PublicKey]      IMAGE            NULL,
    [SymmetricKey]   IMAGE            NULL
);


