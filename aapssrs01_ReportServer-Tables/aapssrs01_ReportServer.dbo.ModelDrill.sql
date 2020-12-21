USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ModelDrill] Script Date: 12/21/2020 8:05:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ModelDrill] (
    [ModelDrillID] UNIQUEIDENTIFIER NOT NULL,
    [ModelID]      UNIQUEIDENTIFIER NOT NULL,
    [ReportID]     UNIQUEIDENTIFIER NOT NULL,
    [ModelItemID]  NVARCHAR (425)   NOT NULL,
    [Type]         TINYINT          NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_ModelDrillModelID]
    ON [dbo].[ModelDrill]([ModelID] ASC, [ReportID] ASC, [ModelDrillID] ASC);


GO
ALTER TABLE [dbo].[ModelDrill]
    ADD CONSTRAINT [PK_ModelDrill] PRIMARY KEY NONCLUSTERED ([ModelDrillID] ASC);


GO
ALTER TABLE [dbo].[ModelDrill]
    ADD CONSTRAINT [FK_ModelDrillModel] FOREIGN KEY ([ModelID]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[ModelDrill]
    ADD CONSTRAINT [FK_ModelDrillReport] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Catalog] ([ItemID]);


