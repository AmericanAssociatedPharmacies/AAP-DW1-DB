USE [NCPDPODS]
GO
/****** Object:  Table [Staging].[NCPDPFact]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[NCPDPFact](
	[ProviderInformationKey] [int] NOT NULL,
	[ePrescribingInformationKey] [int] NOT NULL,
	[StateLicenseKey] [int] NOT NULL,
	[MedicaidKey] [int] NOT NULL,
	[TaxonomyKey] [int] NOT NULL,
	[ChangeofOwnershipKey] [int] NOT NULL,
	[ServicesOfferedKey] [int] NOT NULL,
	[ProviderRelationshipKey] [int] NOT NULL,
	[RemitAndReconciliationKey] [int] NOT NULL,
	[RelationshipDemographicKey] [int] NOT NULL,
	[PaymentCenterKey] [int] NOT NULL,
	[ParentOrganizationKey] [int] NOT NULL,
 CONSTRAINT [CPK_NCPDPFact] PRIMARY KEY CLUSTERED 
(
	[ProviderInformationKey] ASC,
	[ePrescribingInformationKey] ASC,
	[StateLicenseKey] ASC,
	[MedicaidKey] ASC,
	[TaxonomyKey] ASC,
	[ChangeofOwnershipKey] ASC,
	[ServicesOfferedKey] ASC,
	[ProviderRelationshipKey] ASC,
	[RemitAndReconciliationKey] ASC,
	[RelationshipDemographicKey] ASC,
	[PaymentCenterKey] ASC,
	[ParentOrganizationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
