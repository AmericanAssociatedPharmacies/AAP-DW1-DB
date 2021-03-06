USE [NCPDPODS]
GO
/****** Object:  View [dbo].[vw_RelationshipDemographicInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_RelationshipDemographicInformation]

AS


SELECT RelationshipDemographicKey, RelationshipID, RelationshipType, Name, Address1, Address2, City, StateCode, ZipCode, PhoneNumber, Extension
, FAXNumber, RelationshipNPI, RelationShipFederalTaxID, ContactName, ContactTitle, EmailAddress, ContractualContactName, ContractualContactTitle
, ContractualContactEmail, OperationalContactName, OperationalContactTitle, OperationalContactEmail, TechnicalContactName, TechnicalContactTitle
, TechnicalContactEmail, AuditContactName, AuditContactTitle, AuditContactEmail, ParentOrganizationID
, CONVERT(DATE, CASE	
				WHEN EffectiveFromDate = '00000000' THEN '29991231'
				ELSE RIGHT(EffectiveFromDate, 4) + LEFT(EffectiveFromDate, 2) +  SUBSTRING(EffectiveFromDate,3,2)
				END
				) AS EffectiveFromDate
, CONVERT(DATE, CASE	
				WHEN DeleteDate = '00000000' THEN '29991231'
				ELSE RIGHT(DeleteDate, 4) + LEFT(DeleteDate, 2) +  SUBSTRING(DeleteDate,3,2)
				END
				) AS DeleteDate
, RowCreatedDate
FROM [dbo].[RelationshipDemographicInformation]
GO
