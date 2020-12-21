USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ConfigurationInfo] Script Date: 12/21/2020 8:02:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ConfigurationInfo] (
    [ConfigInfoID] UNIQUEIDENTIFIER NOT NULL,
    [Name]         NVARCHAR (260)   NOT NULL,
    [Value]        NTEXT            NOT NULL
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[ConfigurationInfo]', @OptionName = N'text in row', @OptionValue = N'256';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_ConfigurationInfo]
    ON [dbo].[ConfigurationInfo]([Name] ASC);


GO
ALTER TABLE [dbo].[ConfigurationInfo]
    ADD CONSTRAINT [PK_ConfigurationInfo] PRIMARY KEY NONCLUSTERED ([ConfigInfoID] ASC);


