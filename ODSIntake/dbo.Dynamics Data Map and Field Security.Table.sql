USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Dynamics Data Map and Field Security]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dynamics Data Map and Field Security](
	[ï»¿In Use] [varchar](500) NULL,
	[Logical Name] [varchar](500) NULL,
	[Schema Name] [varchar](500) NULL,
	[Display Name] [varchar](500) NULL,
	[Type] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Custom Attribute] [varchar](500) NULL,
	[Required Level] [varchar](500) NULL,
	[Audit Enabled] [varchar](500) NULL,
	[Field Security] [varchar](500) NULL,
	[Form Location] [varchar](500) NULL,
	[Additional data] [varchar](8000) NULL,
	[Field Security - Accounting] [varchar](500) NULL,
	[Field Security - Compliance] [varchar](500) NULL,
	[Field Security - Customer Service Manager] [varchar](500) NULL,
	[Field Security - Customer Service Rep] [varchar](500) NULL,
	[Field Security - Data Reporting Specialist] [varchar](500) NULL,
	[Field Security - Executive] [varchar](500) NULL,
	[Field Security - Inside Sales] [varchar](500) NULL,
	[Field Security - Marketing] [varchar](500) NULL,
	[Field Security - Onboarding] [varchar](500) NULL,
	[Field Security - Sales] [varchar](500) NULL,
	[Field Security - Sales Admin] [varchar](500) NULL,
	[Field Security - Sales Manager] [varchar](500) NULL,
	[Field Security - System Administrator] [varchar](500) NULL,
	[Field Security - Team (Read + Activities)] [varchar](500) NULL,
	[Field Security - Team (Read Only)] [varchar](500) NULL
) ON [PRIMARY]
GO
