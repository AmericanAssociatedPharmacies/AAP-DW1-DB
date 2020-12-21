USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ModelPerspective] Script Date: 12/21/2020 8:07:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ModelPerspective] (
    [ID]                     UNIQUEIDENTIFIER NOT NULL,
    [ModelID]                UNIQUEIDENTIFIER NOT NULL,
    [PerspectiveID]          NTEXT            NOT NULL,
    [PerspectiveName]        NTEXT            NULL,
    [PerspectiveDescription] NTEXT            NULL
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[ModelPerspective]', @OptionName = N'text in row', @OptionValue = N'256';


GO
CREATE CLUSTERED INDEX [IX_ModelPerspective]
    ON [dbo].[ModelPerspective]([ModelID] ASC);


GO
ALTER TABLE [dbo].[ModelPerspective]
    ADD CONSTRAINT [FK_ModelPerspectiveModel] FOREIGN KEY ([ModelID]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


