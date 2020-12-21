USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Batch] Script Date: 12/21/2020 7:59:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Batch] (
    [BatchID]    UNIQUEIDENTIFIER NOT NULL,
    [AddedOn]    DATETIME         NOT NULL,
    [Action]     VARCHAR (32)     NOT NULL,
    [Item]       NVARCHAR (425)   NULL,
    [Parent]     NVARCHAR (425)   NULL,
    [Param]      NVARCHAR (425)   NULL,
    [BoolParam]  BIT              NULL,
    [Content]    IMAGE            NULL,
    [Properties] NTEXT            NULL
);


GO
CREATE CLUSTERED INDEX [IX_Batch]
    ON [dbo].[Batch]([BatchID] ASC, [AddedOn] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Batch_1]
    ON [dbo].[Batch]([AddedOn] ASC);


