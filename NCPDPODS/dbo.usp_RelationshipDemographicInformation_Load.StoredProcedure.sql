USE [NCPDPODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RelationshipDemographicInformation_Load]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_RelationshipDemographicInformation_Load]

AS

SET NOCOUNT ON;

BEGIN

	MERGE [dbo].[RelationshipDemographicInformation] AS T
	USING (SELECT [RelationshipID], [RelationshipType], [Name], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber], [RelationshipNPI], [RelationShipFederalTaxID]
				, [ContactName], [ContactTitle], [EmailAddress], [ContractualContactName], [ContractualContactTitle], [ContractualContactEmail], [OperationalContactName], [OperationalContactTitle], [OperationalContactEmail]
				, [TechnicalContactName], [TechnicalContactTitle], [TechnicalContactEmail], [AuditContactName], [AuditContactTitle], [AuditContactEmail], [ParentOrganizationID], [EffectiveFromDate], [DeleteDate]
		   FROM [Staging].[vw_NCPDP_RelationshipDemographicInformation]) AS S
				([RelationshipID], [RelationshipType], [Name], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber], [RelationshipNPI]
				, [RelationShipFederalTaxID], [ContactName], [ContactTitle], [EmailAddress], [ContractualContactName], [ContractualContactTitle], [ContractualContactEmail], [OperationalContactName]
				, [OperationalContactTitle], [OperationalContactEmail], [TechnicalContactName], [TechnicalContactTitle], [TechnicalContactEmail], [AuditContactName], [AuditContactTitle], [AuditContactEmail]
				, [ParentOrganizationID], [EffectiveFromDate], [DeleteDate])
		  ON T.[RelationshipID] = S.[RelationshipID]

WHEN MATCHED THEN

UPDATE SET   [RelationshipType] = S.[RelationshipType]
		   , [Name] = S.[Name]
		   , [Address1] = S.[Address1]
		   , [Address2] = S.[Address2]
		   , [City] = S.[City]
		   , [StateCode] = S.[StateCode]
		   , [ZipCode] = S.[ZipCode]
		   , [PhoneNumber] = S.[PhoneNumber]
		   , [Extension] = S.[Extension]
		   , [FAXNumber] = S.[FAXNumber]
		   , [RelationshipNPI] = S.[RelationshipNPI]
		   , [RelationShipFederalTaxID] = S.[RelationShipFederalTaxID]
		   , [ContactName] = S.[ContactName]
		   , [ContactTitle] = S.[ContactTitle]
		   , [EmailAddress] = S.[EmailAddress]
		   , [ContractualContactName] = S.[ContractualContactName]
		   , [ContractualContactTitle] = S.[ContractualContactTitle]
		   , [ContractualContactEmail] = S.[ContractualContactEmail]
		   , [OperationalContactName] = S.[OperationalContactName]
		   , [OperationalContactTitle] = S.[OperationalContactTitle]
		   , [OperationalContactEmail] = S.[OperationalContactEmail]
		   , [TechnicalContactName] = S.[TechnicalContactName]
		   , [TechnicalContactTitle] = S.[TechnicalContactTitle]
		   , [TechnicalContactEmail] = S.[TechnicalContactEmail]
		   , [AuditContactName] = S.[AuditContactName]
		   , [AuditContactTitle] = S.[AuditContactTitle]
		   , [AuditContactEmail] = S.[AuditContactEmail]
		   , [ParentOrganizationID] = S.[ParentOrganizationID]
		   , [EffectiveFromDate] = S.[EffectiveFromDate]
		   , [DeleteDate] = S.[DeleteDate]

WHEN NOT MATCHED THEN
		INSERT ([RelationshipID], [RelationshipType], [Name], [Address1], [Address2], [City], [StateCode], [ZipCode], [PhoneNumber], [Extension], [FAXNumber], [RelationshipNPI], [RelationShipFederalTaxID]
				, [ContactName], [ContactTitle], [EmailAddress], [ContractualContactName], [ContractualContactTitle], [ContractualContactEmail], [OperationalContactName], [OperationalContactTitle], [OperationalContactEmail]
				, [TechnicalContactName], [TechnicalContactTitle], [TechnicalContactEmail], [AuditContactName], [AuditContactTitle], [AuditContactEmail], [ParentOrganizationID], [EffectiveFromDate], [DeleteDate])
		VALUES (S.[RelationshipID], S.[RelationshipType], S.[Name], S.[Address1], S.[Address2], S.[City], S.[StateCode], S.[ZipCode], S.[PhoneNumber], S.[Extension], S.[FAXNumber], S.[RelationshipNPI], S.[RelationShipFederalTaxID]
				, S.[ContactName], S.[ContactTitle], S.[EmailAddress], S.[ContractualContactName], S.[ContractualContactTitle], S.[ContractualContactEmail], S.[OperationalContactName], S.[OperationalContactTitle], S.[OperationalContactEmail]
				, S.[TechnicalContactName], S.[TechnicalContactTitle], S.[TechnicalContactEmail], S.[AuditContactName], S.[AuditContactTitle], S.[AuditContactEmail], S.[ParentOrganizationID], S.[EffectiveFromDate], S.[DeleteDate]);
END


GO
