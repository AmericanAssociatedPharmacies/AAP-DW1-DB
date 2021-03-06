USE [WebDev]
GO
/****** Object:  Table [dbo].[BusinessAnalysisCalculator]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessAnalysisCalculator](
	[CalculatorID] [int] IDENTITY(1,1) NOT NULL,
	[TotalBrandSpend] [decimal](18, 4) NOT NULL,
	[CogDiscountPercentage] [decimal](18, 4) NOT NULL,
	[AdditionalBrandCogBrandDiscountReceived] [bit] NOT NULL,
	[AdditionalBrandCogBrandDiscountPercentage] [decimal](18, 4) NULL,
	[BrandPurchasedDiscountRate] [bit] NOT NULL,
	[BrandPurchasedDiscountAmount] [decimal](18, 4) NULL,
	[BrandPurchasedDiscountPercentage] [decimal](18, 4) NULL,
	[purchaseAgreementCompliance] [bit] NULL,
	[GenericComplianceRatio] [bit] NOT NULL,
	[GenericBrandRatio] [bit] NOT NULL,
	[KnowRatioPercentage] [bit] NOT NULL,
	[RatioPercentage] [decimal](18, 4) NULL,
	[TiedCogToBrandRxPurchaseRate] [bit] NOT NULL,
	[CogToBrandRxPurchasePercentage] [decimal](18, 4) NULL,
	[BrandToPurchseOfStores] [bit] NOT NULL,
	[BrandToPurchseOfStoresGroup] [nvarchar](200) NULL,
	[AverageTotalMonthlyGenericRxSpend] [decimal](18, 4) NOT NULL,
	[AverageTotalMonthlyGenericRebatePercentage] [decimal](18, 4) NOT NULL,
	[AverageMonthlyGenericRebateReceived] [decimal](18, 4) NOT NULL,
	[MonthlyGenericRxNotEarnRebates] [decimal](18, 4) NOT NULL,
	[GenericRebateToGPR] [bit] NOT NULL,
	[GenericRebateToGPRPercentage] [decimal](18, 4) NULL,
	[PrimeVendorOrPurchaseContract] [bit] NOT NULL,
	[WholesalerPaymentTerms] [varchar](50) NOT NULL,
	[CalBRxCostofInventory] [decimal](18, 4) NOT NULL,
	[CalOtherBRxCostofInventory] [decimal](18, 4) NOT NULL,
	[CalTotalBRxCostofInventory] [decimal](18, 4) NOT NULL,
	[CalRebate] [decimal](18, 4) NOT NULL,
	[CalTotalGRxCostofInventory] [decimal](18, 4) NOT NULL,
	[CalGenericComplianceRatioGCR] [decimal](18, 4) NOT NULL,
	[CalGenericToBrandRatioGBR] [decimal](18, 4) NOT NULL,
	[CalCostofRxInventory] [decimal](18, 4) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[PharmacyName] [varchar](100) NOT NULL,
	[PrimeVendorWholesaler] [varchar](100) NULL,
	[PrimeVendorContractExpireDate] [nvarchar](50) NULL,
	[PrimeVendorUpfrontCash] [decimal](18, 4) NULL,
	[MultiStoreOperation] [bit] NOT NULL,
	[NumberOfMultiStoreOperation] [int] NULL,
 CONSTRAINT [PK__tmp_ms_x__C70B25BA20494AC0] PRIMARY KEY CLUSTERED 
(
	[CalculatorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BusinessAnalysisCalculator] ADD  CONSTRAINT [DF__tmp_ms_xx__RowCr__54C30A1C]  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[BusinessAnalysisCalculator] ADD  CONSTRAINT [DF_BusinessAnalysisCalculator_NumberOfMultiStoreOperation]  DEFAULT ((0)) FOR [NumberOfMultiStoreOperation]
GO
