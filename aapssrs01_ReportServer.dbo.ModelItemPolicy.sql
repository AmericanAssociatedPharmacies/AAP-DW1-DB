USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ModelItemPolicy] Script Date: 12/21/2020 8:06:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ModelItemPolicy] (
    [ID]            UNIQUEIDENTIFIER NOT NULL,
    [CatalogItemID] UNIQUEIDENTIFIER NOT NULL,
    [ModelItemID]   NVARCHAR (425)   NOT NULL,
    [PolicyID]      UNIQUEIDENTIFIER NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_ModelItemPolicy]
    ON [dbo].[ModelItemPolicy]([CatalogItemID] ASC, [ModelItemID] ASC);


GO
ALTER TABLE [dbo].[ModelItemPolicy]
    ADD CONSTRAINT [PK_ModelItemPolicy] PRIMARY KEY NONCLUSTERED ([ID] ASC);


GO
ALTER TABLE [dbo].[ModelItemPolicy]
    ADD CONSTRAINT [FK_PoliciesPolicyID] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policies] ([PolicyID]) ON DELETE CASCADE;


