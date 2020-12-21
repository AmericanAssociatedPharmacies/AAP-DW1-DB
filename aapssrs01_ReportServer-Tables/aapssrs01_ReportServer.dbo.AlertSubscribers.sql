USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[AlertSubscribers] Script Date: 12/21/2020 7:33:25 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AlertSubscribers] (
    [AlertSubscriptionID] BIGINT           IDENTITY (1, 1) NOT NULL,
    [AlertType]           NVARCHAR (50)    NOT NULL,
    [UserID]              UNIQUEIDENTIFIER NOT NULL,
    [ItemID]              UNIQUEIDENTIFIER NOT NULL
);


