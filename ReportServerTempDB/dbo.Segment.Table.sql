USE [ReportServerTempDB]
GO
/****** Object:  Table [dbo].[Segment]    Script Date: 12/22/2020 7:48:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Segment](
	[SegmentId] [uniqueidentifier] NOT NULL,
	[Content] [varbinary](max) NULL,
 CONSTRAINT [PK_Segment] PRIMARY KEY CLUSTERED 
(
	[SegmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Segment] ADD  CONSTRAINT [DF_Segment_SegmentId]  DEFAULT (newsequentialid()) FOR [SegmentId]
GO
