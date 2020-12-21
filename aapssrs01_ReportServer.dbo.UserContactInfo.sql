USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[UserContactInfo] Script Date: 12/21/2020 8:11:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserContactInfo] (
    [UserID]              UNIQUEIDENTIFIER NOT NULL,
    [DefaultEmailAddress] NVARCHAR (256)   NULL
);


