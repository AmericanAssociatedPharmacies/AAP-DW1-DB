USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CRM_AffiliateHistory]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CRM_AffiliateHistory](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[createdby] [uniqueidentifier] NULL,
	[createdbyname] [nvarchar](100) NULL,
	[createdbyyominame] [nvarchar](100) NULL,
	[createdon] [datetime] NULL,
	[createdonbehalfby] [uniqueidentifier] NULL,
	[createdonbehalfbyname] [nvarchar](100) NULL,
	[createdonbehalfbyyominame] [nvarchar](100) NULL,
	[importsequencenumber] [int] NULL,
	[modifiedby] [uniqueidentifier] NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[modifiedbyyominame] [nvarchar](100) NULL,
	[modifiedon] [datetime] NULL,
	[modifiedonbehalfby] [uniqueidentifier] NULL,
	[modifiedonbehalfbyname] [nvarchar](100) NULL,
	[modifiedonbehalfbyyominame] [nvarchar](100) NULL,
	[new_accountid] [uniqueidentifier] NULL,
	[new_accountidname] [nvarchar](160) NULL,
	[new_accountidyominame] [nvarchar](160) NULL,
	[new_affiliategroup] [int] NULL,
	[new_affiliategroupname] [nvarchar](250) NULL,
	[new_affiliateid] [uniqueidentifier] NULL,
	[new_affiliationend] [date] NULL,
	[new_affiliationstart] [date] NULL,
	[new_name] [nvarchar](100) NULL,
	[new_newaffiliation] [nvarchar](4000) NULL,
	[new_reason] [nvarchar](100) NULL,
	[organizationid] [uniqueidentifier] NULL,
	[organizationidname] [nvarchar](100) NULL,
	[overriddencreatedon] [date] NULL,
	[statecode] [int] NULL,
	[statecodename] [nvarchar](250) NULL,
	[statuscode] [int] NULL,
	[statuscodename] [nvarchar](250) NULL,
	[timezoneruleversionnumber] [int] NULL,
	[utcconversiontimezonecode] [int] NULL,
	[versionnumber] [bigint] NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CRM_AffiliateHistory] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
