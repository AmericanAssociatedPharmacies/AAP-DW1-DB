USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Segment] Script Date: 12/21/2020 8:09:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Segment] (
    [SegmentId] UNIQUEIDENTIFIER NOT NULL,
    [Content]   VARBINARY (MAX)  NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SegmentMetadata]
    ON [dbo].[Segment]([SegmentId] ASC);


GO
ALTER TABLE [dbo].[Segment]
    ADD CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED ([SegmentId] ASC);


GO
ALTER TABLE [dbo].[Segment]
    ADD CONSTRAINT [DF_Segment_SegmentId] DEFAULT (newsequentialid()) FOR [SegmentId];


