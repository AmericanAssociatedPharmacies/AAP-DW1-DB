USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CardinalCatalog]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CardinalCatalog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NULL,
	[FileRowID] [int] NOT NULL,
	[CIN] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[Size] [varchar](500) NULL,
	[Strength] [varchar](500) NULL,
	[Col5] [varchar](500) NULL,
	[Cost] [varchar](500) NULL,
	[Col7] [varchar](500) NULL,
	[Col8] [varchar](500) NULL,
	[Col9] [varchar](500) NULL,
	[Col10] [varchar](500) NULL,
	[Col11] [varchar](500) NULL,
	[Col12] [varchar](500) NULL,
	[Col13] [varchar](500) NULL,
	[Col14] [varchar](500) NULL,
	[Col15] [varchar](500) NULL,
	[Col16] [varchar](500) NULL,
	[Col17] [varchar](500) NULL,
	[FileDir] [varchar](1000) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_CardinalCatalog] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
