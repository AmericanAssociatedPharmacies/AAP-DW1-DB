USE [ODSIntake]
GO
/****** Object:  Table [Archive].[ABC]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[ABC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NULL,
	[ABCItemNum] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[ABC_AWP] [varchar](500) NULL,
	[ABCInvoicePrice] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_ABC_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[ABC] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
