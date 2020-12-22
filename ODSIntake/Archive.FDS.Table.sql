USE [ODSIntake]
GO
/****** Object:  Table [Archive].[FDS]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[FDS](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NULL,
	[ClaimStatusCode] [varchar](500) NULL,
	[ServiceProviderIDQualifier] [varchar](500) NULL,
	[ServiceProviderID] [varchar](500) NULL,
	[TransactionDate] [varchar](500) NULL,
	[RxNumber] [varchar](500) NULL,
	[RefillNumber] [varchar](500) NULL,
	[FillDate] [varchar](500) NULL,
	[DispensedProductQualifier] [varchar](500) NULL,
	[DispensedProductID] [varchar](500) NULL,
	[PayerSequence] [varchar](500) NULL,
	[BIN] [varchar](500) NULL,
	[PCN] [varchar](500) NULL,
	[GroupNumber] [varchar](500) NULL,
	[InsurerCode] [varchar](500) NULL,
	[InsurerName] [varchar](500) NULL,
	[PlanCode] [varchar](500) NULL,
	[PlanName] [varchar](500) NULL,
	[PrescriberQualifier] [varchar](500) NULL,
	[PrescriberSubmittedID] [varchar](500) NULL,
	[PrescriberLastName] [varchar](500) NULL,
	[PrescriberFirstName] [varchar](500) NULL,
	[PrescriberStreetAddress] [varchar](500) NULL,
	[PrescriberCity] [varchar](500) NULL,
	[PrescriberStateCode] [varchar](500) NULL,
	[PrescriberZipCode] [varchar](500) NULL,
	[PrescriberPhoneNumber] [varchar](500) NULL,
	[OriginallyPrescribedProduct] [varchar](500) NULL,
	[PrescribedRefills] [varchar](500) NULL,
	[RxExpirationDate] [varchar](500) NULL,
	[DAW] [varchar](500) NULL,
	[DateWritten] [varchar](500) NULL,
	[OriginCode] [varchar](500) NULL,
	[CompoundCode] [varchar](500) NULL,
	[TotalQuantity] [varchar](500) NULL,
	[ContractCost] [varchar](500) NULL,
	[AverageWholeSalePrice] [varchar](500) NULL,
	[UsualAndCustomary] [varchar](500) NULL,
	[CopayAmountSubmitted] [varchar](500) NULL,
	[IngredientCostSubmitted] [varchar](500) NULL,
	[DispensingFeeSubmitted] [varchar](500) NULL,
	[IncentiveFeeSubmitted] [varchar](500) NULL,
	[SalesTaxSubmitted] [varchar](500) NULL,
	[CopayAmountPaid] [varchar](500) NULL,
	[IngredientCostPaid] [varchar](500) NULL,
	[DispensingFeePaid] [varchar](500) NULL,
	[SalesTaxPaid] [varchar](500) NULL,
	[IncentiveFeePaid] [varchar](500) NULL,
	[ClaimAmountPaid] [varchar](500) NULL,
	[BasisOfCostCode] [varchar](500) NULL,
	[QuantityDispensed] [varchar](500) NULL,
	[DaysSupply] [varchar](500) NULL,
	[PharmacistInitials] [varchar](500) NULL,
	[RejectMessageCount] [varchar](500) NULL,
	[RejectMessages] [varchar](500) NULL,
	[AuthorizationNumber] [varchar](500) NULL,
	[BasisOfReimbursementDetermination] [varchar](500) NULL,
	[PlaceOfService] [varchar](500) NULL,
	[ProviderIDQualifier] [varchar](500) NULL,
	[ProviderID] [varchar](500) NULL,
	[AdjustedContractCost] [varchar](500) NULL,
	[P340BCode] [varchar](500) NULL,
	[PrescriptionStatus] [varchar](500) NULL,
	[ProductSource] [varchar](500) NULL,
	[PMID] [varchar](500) NULL,
	[FileSource] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NOT NULL,
	[RowversionID] [varbinary](8) NULL,
 CONSTRAINT [CPK_Staging_FDS] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[FDS] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
