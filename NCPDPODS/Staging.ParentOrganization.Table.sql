USE [NCPDPODS]
GO
/****** Object:  Table [Staging].[ParentOrganization]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ParentOrganization](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ParentOrganizationID] [varchar](6) NULL,
	[ParentOrganizationName] [varchar](35) NULL,
	[Address1] [varchar](55) NULL,
	[Address2] [varchar](55) NULL,
	[City] [varchar](30) NULL,
	[StateCode] [varchar](2) NULL,
	[ZipCode] [varchar](9) NULL,
	[PhoneNumber] [varchar](10) NULL,
	[Extension] [varchar](5) NULL,
	[FAXNumber] [varchar](10) NULL,
	[ParentOrganizationNPI] [varchar](10) NULL,
	[ParentOrganizationFederalTaxID] [varchar](15) NULL,
	[ContactName] [varchar](30) NULL,
	[ContactTitle] [varchar](30) NULL,
	[EmailAddress] [varchar](50) NULL,
	[DeleteDate] [varchar](8) NULL,
	[RowCreatedDatate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ParentOrganization] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ParentOrganization] ADD  DEFAULT (getdate()) FOR [RowCreatedDatate]
GO
