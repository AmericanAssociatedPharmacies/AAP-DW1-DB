USE [ODSIntake]
GO
/****** Object:  Table [Staging].[McKesson_old_20180523]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[McKesson_old_20180523](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[ItemNum] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[GenericDesc] [varchar](500) NULL,
	[CurrentPrice] [varchar](500) NULL,
	[FileDir] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_McKesson] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
