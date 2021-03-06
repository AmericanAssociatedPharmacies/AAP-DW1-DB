USE [SalesDDS]
GO
/****** Object:  Table [Staging].[DrugDim]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[DrugDim](
	[DrugKey] [int] NOT NULL,
	[NDC] [varchar](11) NULL,
	[GPI] [varchar](14) NULL,
	[GPPC] [varchar](25) NULL,
	[DrugName] [varchar](25) NULL,
	[Description] [varchar](500) NULL,
	[Manufacturer] [varchar](30) NULL,
	[DrugType] [varchar](50) NULL,
	[UnitofMeasure] [varchar](2) NULL,
	[Form] [varchar](4) NULL,
	[PackageSize] [numeric](8, 3) NULL,
	[IsRX] [int] NOT NULL,
	[IsOTC] [int] NOT NULL,
	[Strength] [varchar](25) NULL,
	[StrengthUnitMeasure] [varchar](11) NULL,
	[ControlledDrugClass] [int] NOT NULL,
	[WACPackagePrice] [numeric](10, 2) NULL,
	[WACPerDose] [numeric](13, 5) NULL,
	[AWPPackagePrice] [numeric](10, 2) NULL,
	[AWPPerDose] [numeric](13, 5) NULL,
	[IsUnitDose] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DrugTypeLongDescription] [varchar](25) NULL,
	[DrugTypeShortDescription] [varchar](25) NULL,
	[IsGenericNonOTC] [bit] NOT NULL,
	[IsBrandNonOTC] [bit] NOT NULL,
	[MultiSourceCode] [varchar](5) NULL,
	[MultiSourceCodeDescription] [varchar](500) NULL,
	[IsMultiSourceBrandNoGenerics] [bit] NOT NULL,
	[IsSingleSourceBrandNoGenerics] [bit] NOT NULL,
	[IsOriginalBrandWithGenerics] [bit] NOT NULL,
	[IsGeneric] [bit] NOT NULL,
	[BrandNameCode] [char](1) NULL,
	[BrandNameCodeDescription] [varchar](500) NULL,
	[StartDateKey] [int] NULL,
	[EndDateKey] [int] NULL,
	[PackageQuantity] [numeric](37, 0) NULL,
	[IsCAHGeneric] [bit] NULL,
	[IsAPITier1] [bit] NOT NULL,
	[IsAPITier2] [bit] NOT NULL,
	[APIGroupID] [varchar](25) NULL,
	[RowUpdatedDate] [datetime] NULL,
	[IsSPX] [bit] NOT NULL,
	[GPIKey] [int] NULL,
 CONSTRAINT [CPK_Staging_DrugDim] PRIMARY KEY CLUSTERED 
(
	[DrugKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsGenericNonOTC]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsBrandNonOTC]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsMultiSourceBrandNoGenerics]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsSingleSourceBrandNoGenerics]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsOriginalBrandWithGenerics]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsGeneric]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsAPITier1]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsAPITier2]
GO
ALTER TABLE [Staging].[DrugDim] ADD  DEFAULT ((0)) FOR [IsSPX]
GO
