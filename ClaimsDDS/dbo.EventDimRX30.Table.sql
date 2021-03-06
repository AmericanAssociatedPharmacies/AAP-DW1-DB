USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[EventDimRX30]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventDimRX30](
	[EventKey] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[ServiceProviderID] [varchar](25) NULL,
	[BINNumber] [varchar](25) NULL,
	[ProcessorControlNumber] [varchar](25) NULL,
	[GroupID] [varchar](250) NULL,
	[ClaimSubmittedDate] [datetime] NOT NULL,
	[DateOfService] [date] NOT NULL,
	[DaysSupply] [int] NULL,
	[NDC] [varchar](25) NULL,
	[BasisOfSubmission] [varchar](25) NULL,
	[OtherCoverageCode] [varchar](25) NULL,
	[DAW] [varchar](25) NULL,
	[DAWDescription] [varchar](8000) NULL,
	[PlanID] [varchar](25) NULL,
	[RejectCode] [varchar](10) NULL,
	[RejectCodeDescription] [varchar](8000) NULL,
	[MessageResponse] [varchar](8000) NULL,
	[TransactionResponseStatus] [varchar](25) NULL,
	[PrescriptionNumber] [varchar](25) NULL,
	[RefillNumberCode] [int] NULL,
	[RefillNumberCodeDescription] [varchar](100) NULL,
	[ProviderIDQualifier] [varchar](10) NULL,
	[ProviderID] [varchar](50) NULL,
	[DoctorName] [varchar](500) NULL,
	[NumberOfRefillsAuthorized] [int] NULL,
	[NDC_As_Written] [varchar](25) NULL,
	[PayerType] [varchar](25) NULL,
	[PharmacySystemLicenseNumber] [varchar](25) NULL,
	[CompoundCode] [int] NULL,
	[CompoundCodeDescription] [varchar](25) NULL,
	[NetworkReimbursementID] [varchar](25) NULL,
	[PrescriptionOriginCode] [varchar](10) NULL,
	[PhysicianDEA] [varchar](25) NULL,
	[PrescriberNPI] [varchar](25) NULL,
	[AuthorizationNumber] [varchar](25) NULL,
	[GenericProductIndicator] [varchar](100) NULL,
	[GenericContractNumber] [varchar](100) NULL,
	[Manufacturer] [varchar](250) NULL,
	[ContractType] [varchar](100) NULL,
	[DrugDescription] [varchar](250) NULL,
	[Form] [varchar](100) NULL,
	[Size] [varchar](100) NULL,
	[Strength] [varchar](100) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowVersionID] [varbinary](8) NOT NULL,
	[DateSold] [date] NULL,
	[OldEventDimPk] [int] NULL,
 CONSTRAINT [CPK_EventDim_EventKey] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [EventDimFG],
 CONSTRAINT [AK_EventDimRX30] UNIQUE NONCLUSTERED 
(
	[EventKey] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [EventDimFG]
) ON [EventDimFG]
GO
ALTER TABLE [dbo].[EventDimRX30] ADD  DEFAULT ('19000101') FOR [ClaimSubmittedDate]
GO
ALTER TABLE [dbo].[EventDimRX30] ADD  DEFAULT ('19000101') FOR [DateOfService]
GO
ALTER TABLE [dbo].[EventDimRX30] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[EventDimRX30] ADD  DEFAULT ('19000101') FOR [DateSold]
GO
