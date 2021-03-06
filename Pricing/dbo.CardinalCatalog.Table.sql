USE [Pricing]
GO
/****** Object:  Table [dbo].[CardinalCatalog]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardinalCatalog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NDC] [varchar](11) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[Size] [decimal](8, 2) NULL,
	[DateKey] [int] NOT NULL,
	[ContractType] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_CardinalCatalog_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CardinalCatalog] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
