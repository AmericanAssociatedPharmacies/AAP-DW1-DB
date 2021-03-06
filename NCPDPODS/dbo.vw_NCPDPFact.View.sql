USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_NCPDPFact]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_NCPDPFact]

AS

SELECT ProviderInformationKey, ePrescribingInformationKey, StateLicenseKey, MedicaidKey, TaxonomyKey, ChangeofOwnershipKey, ServicesOfferedKey, FraudKey, ProviderRelationshipKey, RemitAndReconciliationKey, RelationshipDemographicKey, PaymentCenterKey, ParentOrganizationKey, RowCreatedDate
FROM [dbo].[NCPDPFact]
GO
