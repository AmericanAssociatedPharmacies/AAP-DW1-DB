USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[RelationshipDemographicInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RelationshipDemographicInformation](
	[RelationshipDemographicKey] [int] IDENTITY(1,1) NOT NULL,
	[RelationshipID] [varchar](3) NULL,
	[RelationshipType] [varchar](2) NULL,
	[Name] [varchar](35) NULL,
	[Address1] [varchar](55) NULL,
	[Address2] [varchar](55) NULL,
	[City] [varchar](30) NULL,
	[StateCode] [varchar](2) NULL,
	[ZipCode] [varchar](9) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[Extension] [varchar](5) NULL,
	[FAXNumber] [varchar](10) NULL,
	[RelationshipNPI] [varchar](10) NULL,
	[RelationShipFederalTaxID] [varchar](15) NULL,
	[ContactName] [varchar](30) NULL,
	[ContactTitle] [varchar](30) NULL,
	[EmailAddress] [varchar](50) NULL,
	[ContractualContactName] [varchar](30) NULL,
	[ContractualContactTitle] [varchar](30) NULL,
	[ContractualContactEmail] [varchar](50) NULL,
	[OperationalContactName] [varchar](30) NULL,
	[OperationalContactTitle] [varchar](30) NULL,
	[OperationalContactEmail] [varchar](50) NULL,
	[TechnicalContactName] [varchar](30) NULL,
	[TechnicalContactTitle] [varchar](30) NULL,
	[TechnicalContactEmail] [varchar](50) NULL,
	[AuditContactName] [varchar](30) NULL,
	[AuditContactTitle] [varchar](30) NULL,
	[AuditContactEmail] [varchar](50) NULL,
	[ParentOrganizationID] [varchar](6) NULL,
	[EffectiveFromDate] [varchar](8) NULL,
	[DeleteDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_RelationshipDemographicInformation] PRIMARY KEY CLUSTERED 
(
	[RelationshipDemographicKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RelationshipDemographicInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
