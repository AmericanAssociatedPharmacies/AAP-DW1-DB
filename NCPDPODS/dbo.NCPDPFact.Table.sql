USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[NCPDPFact]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPFact](
	[ProviderInformationKey] [int] NOT NULL,
	[ePrescribingInformationKey] [int] NOT NULL,
	[StateLicenseKey] [int] NOT NULL,
	[MedicaidKey] [int] NOT NULL,
	[TaxonomyKey] [int] NOT NULL,
	[ChangeofOwnershipKey] [int] NOT NULL,
	[ServicesOfferedKey] [int] NOT NULL,
	[FraudKey] [int] NOT NULL,
	[ProviderRelationshipKey] [int] NOT NULL,
	[RemitAndReconciliationKey] [int] NOT NULL,
	[RelationshipDemographicKey] [int] NOT NULL,
	[PaymentCenterKey] [int] NOT NULL,
	[ParentOrganizationKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_NCPDPFact] PRIMARY KEY CLUSTERED 
(
	[ProviderInformationKey] ASC,
	[ePrescribingInformationKey] ASC,
	[StateLicenseKey] ASC,
	[MedicaidKey] ASC,
	[TaxonomyKey] ASC,
	[ChangeofOwnershipKey] ASC,
	[ServicesOfferedKey] ASC,
	[FraudKey] ASC,
	[ProviderRelationshipKey] ASC,
	[RemitAndReconciliationKey] ASC,
	[RelationshipDemographicKey] ASC,
	[PaymentCenterKey] ASC,
	[ParentOrganizationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NCPDPFact] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ChangeOfOwnershipKey] FOREIGN KEY([ChangeofOwnershipKey])
REFERENCES [dbo].[ChangeofOwnershipInformation] ([ChangeOfOwnershipKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ChangeOfOwnershipKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ePrescribingInformationKey] FOREIGN KEY([ePrescribingInformationKey])
REFERENCES [dbo].[ePrescribingInformation] ([ePrescribingInformationKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ePrescribingInformationKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_FraudKey] FOREIGN KEY([FraudKey])
REFERENCES [dbo].[FraudWasteandAbuseTrainingAttestation] ([FraudKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_FraudKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_MedicaidKey] FOREIGN KEY([MedicaidKey])
REFERENCES [dbo].[MedicaidInformation] ([MedicaidKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_MedicaidKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ParentOrganizationKey] FOREIGN KEY([ParentOrganizationKey])
REFERENCES [dbo].[ParentOrganization] ([ParentOrganizationKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ParentOrganizationKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_PaymentCenterKey] FOREIGN KEY([PaymentCenterKey])
REFERENCES [dbo].[PaymentCenterInformation] ([PaymentCenterKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_PaymentCenterKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ProviderInformationKey] FOREIGN KEY([ProviderInformationKey])
REFERENCES [dbo].[ProviderInformation] ([ProviderInformationKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ProviderInformationKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ProviderRelationshipKey] FOREIGN KEY([ProviderRelationshipKey])
REFERENCES [dbo].[ProviderRelationship] ([ProviderRelationshipKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ProviderRelationshipKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_RelationshipDemographicKey] FOREIGN KEY([RelationshipDemographicKey])
REFERENCES [dbo].[RelationshipDemographicInformation] ([RelationshipDemographicKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_RelationshipDemographicKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_RemitAndReconciliationKey] FOREIGN KEY([RemitAndReconciliationKey])
REFERENCES [dbo].[RemitAndReconciliation] ([RemitAndReconciliationKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_RemitAndReconciliationKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_ServicesOfferedKey] FOREIGN KEY([ServicesOfferedKey])
REFERENCES [dbo].[ServicesOffered] ([ServicesOfferedKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_ServicesOfferedKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_StateLicenseKey] FOREIGN KEY([StateLicenseKey])
REFERENCES [dbo].[StateLicense] ([StateLicenseKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_StateLicenseKey]
GO
ALTER TABLE [dbo].[NCPDPFact]  WITH NOCHECK ADD  CONSTRAINT [FK_NCPDPFact_TaxonomyKey] FOREIGN KEY([TaxonomyKey])
REFERENCES [dbo].[Taxonomy] ([TaxonomyKey])
GO
ALTER TABLE [dbo].[NCPDPFact] CHECK CONSTRAINT [FK_NCPDPFact_TaxonomyKey]
GO
