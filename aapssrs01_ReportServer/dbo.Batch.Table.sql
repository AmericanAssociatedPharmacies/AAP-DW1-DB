USE [aapssrs01_ReportServer]
GO
/****** Object:  Table [dbo].[Batch]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch](
	[BatchID] [uniqueidentifier] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[Action] [varchar](32) NOT NULL,
	[Item] [nvarchar](425) NULL,
	[Parent] [nvarchar](425) NULL,
	[Param] [nvarchar](425) NULL,
	[BoolParam] [bit] NULL,
	[Content] [image] NULL,
	[Properties] [ntext] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
