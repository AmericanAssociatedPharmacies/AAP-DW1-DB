USE [NCPDPODS]
GO
/****** Object:  Table [Staging].[FraudWasteandAbuseTrainingAttestation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[FraudWasteandAbuseTrainingAttestation](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[MedicaidID] [varchar](1) NULL,
	[FWAattestation] [varchar](1) NULL,
	[VersionNumber] [varchar](5) NULL,
	[PlanYear] [varchar](4) NULL,
	[Q1] [varchar](1) NULL,
	[Q2] [varchar](1) NULL,
	[AccreditationDate] [varchar](8) NULL,
	[AccreditationOrganization] [varchar](60) NULL,
	[Q3] [varchar](1) NULL,
	[Q4] [varchar](1) NULL,
	[SignatureofResponsiblePart] [varchar](60) NULL,
	[SignatureDate] [varchar](8) NULL,
	[ResponsibleParty] [varchar](60) NULL,
	[ParticipatingPharmacyorPSAOName] [varchar](60) NULL,
	[Address1] [varchar](55) NULL,
	[Address2] [varchar](55) NULL,
	[City] [varchar](30) NULL,
	[StateCode] [varchar](2) NULL,
	[ZipCode] [varchar](9) NULL,
	[NPI] [varchar](10) NULL,
	[Fax] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_FraudWasteandAbuseTrainingAttestation] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[FraudWasteandAbuseTrainingAttestation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
