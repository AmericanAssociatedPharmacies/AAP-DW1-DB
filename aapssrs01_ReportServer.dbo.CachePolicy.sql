USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[CachePolicy] Script Date: 12/21/2020 8:00:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CachePolicy] (
    [CachePolicyID]   UNIQUEIDENTIFIER NOT NULL,
    [ReportID]        UNIQUEIDENTIFIER NOT NULL,
    [ExpirationFlags] INT              NOT NULL,
    [CacheExpiration] INT              NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_CachePolicyReportID]
    ON [dbo].[CachePolicy]([ReportID] ASC);


GO
ALTER TABLE [dbo].[CachePolicy]
    ADD CONSTRAINT [PK_CachePolicy] PRIMARY KEY NONCLUSTERED ([CachePolicyID] ASC);


GO
ALTER TABLE [dbo].[CachePolicy]
    ADD CONSTRAINT [FK_CachePolicyReportID] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


