USE [CAHODS]
GO
/****** Object:  Table [Staging].[CardinalComplete]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CardinalComplete](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[UnitProduct] [varchar](50) NULL,
	[ScannedUnitProductCode] [varchar](50) NULL,
	[NDC] [varchar](50) NULL,
	[CardinalItemNumber] [varchar](50) NULL,
	[RXOTCFlag] [varchar](50) NULL,
	[BrandName] [varchar](50) NULL,
	[GeneralProductDescription] [varchar](50) NULL,
	[AWP] [money] NULL,
	[ContractPrice] [money] NULL,
	[InvoicePrice] [money] NULL,
	[BasePrice] [money] NULL,
	[RetailPrice] [money] NULL,
	[Form] [varchar](50) NULL,
	[Strength] [varchar](50) NULL,
	[Size] [varchar](50) NULL,
	[UnitofMeasure] [varchar](50) NULL,
	[VendorName] [varchar](50) NULL,
	[AccuNetSize] [varchar](50) NULL,
	[CaseQuantity] [varchar](50) NULL,
	[PackQuantity] [varchar](50) NULL,
	[UnitSize] [varchar](50) NULL,
	[DispenseQuantity] [varchar](50) NULL,
	[TheraputicClassCode] [varchar](50) NULL,
	[ContractNumber] [varchar](50) NULL,
	[ContractName] [varchar](50) NULL,
	[ContractStartDate] [varchar](50) NULL,
	[ContractEndDate] [varchar](50) NULL,
	[InvoicePriceChangeDate] [varchar](50) NULL,
	[BasePriceChangeDate] [varchar](50) NULL,
	[FineLineCode] [varchar](50) NULL,
	[PreviousInvoicePrice] [varchar](50) NULL,
	[CCAHeader] [varchar](50) NULL,
	[GenericCode] [varchar](50) NULL,
	[GPPCCode] [varchar](50) NULL,
	[GPI] [varchar](50) NULL,
	[APISize] [varchar](50) NULL,
	[APIItem] [varchar](50) NULL,
	[APIPrice] [money] NULL,
	[AdjRebate] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_CAHComplete] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CardinalComplete] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
