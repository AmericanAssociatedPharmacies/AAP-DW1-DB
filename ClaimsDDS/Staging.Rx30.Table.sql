USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[Rx30]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[Rx30](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[ServiceProviderID] [varchar](25) NULL,
	[BINNumber] [varchar](25) NULL,
	[ProcessorControlNumber] [varchar](25) NULL,
	[GroupID] [varchar](25) NULL,
	[ClaimSubmittedDate] [varchar](25) NULL,
	[DateOfService] [varchar](25) NULL,
	[QuantityDispensed] [decimal](15, 3) NULL,
	[DaysSupply] [int] NULL,
	[BasisOfSubmission] [varchar](25) NULL,
	[NDC] [varchar](25) NULL,
	[DispensingFeeSubmitted] [money] NULL,
	[IngredientCostSubmitted] [money] NULL,
	[DispensingFeePaid] [money] NULL,
	[IngredientCostPaid] [money] NULL,
	[TotalAmountPaid] [money] NULL,
	[AmountofCopay] [money] NULL,
	[UsualandCustomaryCharge] [money] NULL,
	[TotalPrice] [money] NULL,
	[BasisofReimbursementDetermination] [varchar](25) NULL,
	[OtherCoverageCode] [varchar](25) NULL,
	[DAW] [varchar](25) NULL,
	[DAWDescription] [varchar](8000) NULL,
	[PatientPayAmount] [money] NULL,
	[GrossAmountDue] [money] NULL,
	[PlanID] [varchar](25) NULL,
	[RejectCode] [varchar](25) NULL,
	[MessageResponse] [varchar](8000) NULL,
	[TransactionResponseStatus] [varchar](25) NULL,
	[PrescriptionNumber] [varchar](25) NULL,
	[RefillNumberCode] [int] NULL,
	[ProviderIDQualifier] [varchar](25) NULL,
	[ProviderID] [varchar](25) NULL,
	[DoctorName] [varchar](500) NULL,
	[NumberofRefillsAuthorized] [int] NULL,
	[NDCWritten] [varchar](25) NULL,
	[OtherAmount] [money] NULL,
	[PayerType] [varchar](25) NULL,
	[PharmacySystemLicenseNumber] [varchar](25) NULL,
	[CompoundCode] [int] NULL,
	[NetworkReimbursementID] [varchar](25) NULL,
	[PrescriberPhoneNumber] [varchar](25) NULL,
	[PrescriptionOriginCode] [varchar](25) NULL,
	[PhysicianDEA] [varchar](25) NULL,
	[UnitAWP] [money] NULL,
	[FlatSalesTaxAmountPaid] [money] NULL,
	[PercentageSalesTaxAmountPaid] [money] NULL,
	[PercentageSalesTaxRate] [numeric](10, 2) NULL,
	[PercentageSalesTaxBasisPaid] [numeric](10, 2) NULL,
	[IncentiveAmountPaid] [money] NULL,
	[ProfessionalFeePaid] [money] NULL,
	[PrescriberNPI] [varchar](100) NULL,
	[AuthorizationNumber] [varchar](50) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowVersionID] [varbinary](8) NOT NULL,
	[DateSold] [date] NULL,
	[RXDiscount] [money] NULL,
	[PharmacyKey] [int] NOT NULL,
 CONSTRAINT [CPK_Staging_Rx30] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimFact]([DateKey])
) ON [psClaimFact]([DateKey])
GO
ALTER TABLE [Staging].[Rx30] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[Rx30] ADD  DEFAULT ((0)) FOR [PharmacyKey]
GO
