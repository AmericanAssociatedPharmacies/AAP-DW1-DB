USE [ODSIntake]
GO
/****** Object:  Table [Archive].[ABC_Raw]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[ABC_Raw](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[C1] [varchar](max) NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_ABC_Raw_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Archive].[ABC_Raw] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
