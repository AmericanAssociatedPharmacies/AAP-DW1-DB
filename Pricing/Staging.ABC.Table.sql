USE [Pricing]
GO
/****** Object:  Table [Staging].[ABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ABC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NULL,
	[ABCItemNum] [varchar](50) NULL,
	[NDC] [varchar](11) NULL,
	[ABC_AWP] [money] NULL,
	[ABCInvoicePrice] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowversionID] [timestamp] NOT NULL,
 CONSTRAINT [CPK_Staging_ABC_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ABC] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
