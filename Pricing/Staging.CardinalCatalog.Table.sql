USE [Pricing]
GO
/****** Object:  Table [Staging].[CardinalCatalog]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CardinalCatalog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NDC] [varchar](11) NULL,
	[CardinalItemNumber] [varchar](25) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[Size] [decimal](10, 3) NULL,
	[DateKey] [int] NOT NULL,
	[ContractType] [varchar](500) NULL,
	[RowVersionID] [timestamp] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsFormularyFile] [bit] NOT NULL,
	[PricePerUnit] [money] NULL,
 CONSTRAINT [CPK_Staging_CardinalCatalog_RowID] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CardinalCatalog] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[CardinalCatalog] ADD  DEFAULT ((0)) FOR [IsFormularyFile]
GO
