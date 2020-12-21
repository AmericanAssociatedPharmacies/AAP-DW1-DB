USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Favorites] Script Date: 12/21/2020 8:04:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Favorites] (
    [ItemID] UNIQUEIDENTIFIER NOT NULL,
    [UserID] UNIQUEIDENTIFIER NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_Favorites_UserID]
    ON [dbo].[Favorites]([UserID] ASC);


GO
ALTER TABLE [dbo].[Favorites]
    ADD CONSTRAINT [PK_Favorites] PRIMARY KEY NONCLUSTERED ([ItemID] ASC, [UserID] ASC);


GO
ALTER TABLE [dbo].[Favorites]
    ADD CONSTRAINT [FK_Favorites_Catalog] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[Catalog] ([ItemID]);


GO
ALTER TABLE [dbo].[Favorites]
    ADD CONSTRAINT [FK_Favorites_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


