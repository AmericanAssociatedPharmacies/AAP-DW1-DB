USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[EventDimFDS]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventDimFDS](
	[EventKey] [int] IDENTITY(1,1) NOT NULL,
	[Datekey] [int] NOT NULL,
	[ClaimStatusCode] [varchar](1) NULL,
	[ClaimStatusCodeDescription] [varchar](255) NULL,
	[ServiceProviderIDQualifier] [varchar](2) NULL,
	[ServiceProviderIDQualifierDescription] [varchar](255) NULL,
	[ServiceProviderID] [varchar](100) NULL,
	[TransactionDate] [datetime] NULL,
	[PrescriptionNumber] [varchar](100) NULL,
	[FillDate] [date] NULL,
	[DispensedProductQualifier] [varchar](25) NULL,
	[DispensedProductQualifierDescription] [varchar](100) NULL,
	[DispensedProductID] [varchar](100) NULL,
	[PayerSequence] [char](1) NULL,
	[PayerSequenceDescription] [varchar](255) NULL,
	[BIN] [varchar](100) NULL,
	[PCN] [varchar](100) NULL,
	[GroupNumber] [varchar](100) NULL,
	[InsurerCode] [varchar](100) NULL,
	[InsurerName] [varchar](255) NULL,
	[PlanCode] [varchar](100) NULL,
	[PlanName] [varchar](255) NULL,
	[PrescriberQualifier] [varchar](25) NULL,
	[PrescriberQualifierDescription] [varchar](255) NULL,
	[PrescriberSubmittedID] [varchar](25) NULL,
	[PrescriberLastName] [varchar](255) NULL,
	[PrescriberFirstName] [varchar](255) NULL,
	[PrescriberStreetAddress] [varchar](500) NULL,
	[PrescriberCity] [varchar](255) NULL,
	[PrescriberZipCode] [varchar](25) NULL,
	[PrescriberPhoneNumber] [varchar](25) NULL,
	[OriginallyPrescribedProduct] [varchar](25) NULL,
	[RXExpirationDate] [date] NULL,
	[DAW] [varchar](25) NULL,
	[DAWDescription] [varchar](500) NULL,
	[DateWritten] [date] NULL,
	[OriginCode] [varchar](2) NULL,
	[OriginCodeDescription] [varchar](100) NULL,
	[CompoundCode] [varchar](2) NULL,
	[CompoundCodeDescripiton] [varchar](100) NULL,
	[BasisCostCode] [varchar](5) NULL,
	[BasisCostCodeDescription] [varchar](255) NULL,
	[PharmacistInitials] [varchar](25) NULL,
	[RejectMessageCount] [int] NULL,
	[RejectMessages] [varchar](1000) NULL,
	[AuthNumber] [varchar](100) NULL,
	[BasisOfReimbursementDetermination] [varchar](10) NULL,
	[BasisOfReimbursementDeterminationDescription] [varchar](255) NULL,
	[PlaceOfService] [varchar](10) NULL,
	[PlaceOfServiceDescription] [varchar](255) NULL,
	[ProviderIDQualifier] [varchar](10) NULL,
	[ProviderIDQualifierDescription] [varchar](255) NULL,
	[Is340BClaim] [bit] NULL,
	[PrescriptionStatus] [varchar](10) NULL,
	[PrescriptionStatusDescription] [varchar](255) NULL,
	[ProductSource] [varchar](255) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowversionID] [varbinary](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[PMID] [int] NULL,
	[CorrectedPMID] [int] NULL,
 CONSTRAINT [CPK_EventDimFDS] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [EventDimFDS]
) ON [EventDimFDS]
GO
ALTER TABLE [dbo].[EventDimFDS] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
