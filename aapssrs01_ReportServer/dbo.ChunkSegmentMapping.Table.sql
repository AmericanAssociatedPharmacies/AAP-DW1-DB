USE [aapssrs01_ReportServer]
GO
/****** Object:  Table [dbo].[ChunkSegmentMapping]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChunkSegmentMapping](
	[ChunkId] [uniqueidentifier] NOT NULL,
	[SegmentId] [uniqueidentifier] NOT NULL,
	[StartByte] [bigint] NOT NULL,
	[LogicalByteCount] [int] NOT NULL,
	[ActualByteCount] [int] NOT NULL,
 CONSTRAINT [PK_ChunkSegmentMapping] PRIMARY KEY CLUSTERED 
(
	[ChunkId] ASC,
	[SegmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChunkSegmentMapping]  WITH CHECK ADD  CONSTRAINT [Positive_ActualByteCount] CHECK  (([ActualByteCount]>=(0)))
GO
ALTER TABLE [dbo].[ChunkSegmentMapping] CHECK CONSTRAINT [Positive_ActualByteCount]
GO
ALTER TABLE [dbo].[ChunkSegmentMapping]  WITH CHECK ADD  CONSTRAINT [Positive_LogicalByteCount] CHECK  (([LogicalByteCount]>=(0)))
GO
ALTER TABLE [dbo].[ChunkSegmentMapping] CHECK CONSTRAINT [Positive_LogicalByteCount]
GO
ALTER TABLE [dbo].[ChunkSegmentMapping]  WITH CHECK ADD  CONSTRAINT [Positive_StartByte] CHECK  (([StartByte]>=(0)))
GO
ALTER TABLE [dbo].[ChunkSegmentMapping] CHECK CONSTRAINT [Positive_StartByte]
GO
