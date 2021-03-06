USE [ODSIntake]
GO
/****** Object:  Table [dbo].['Account (Account)$']    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['Account (Account)$'](
	[In Use] [bit] NOT NULL,
	[Logical Name] [nvarchar](255) NULL,
	[Schema Name] [nvarchar](255) NULL,
	[Display Name] [nvarchar](255) NULL,
	[Type] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Custom Attribute] [nvarchar](255) NULL,
	[Required Level] [nvarchar](255) NULL,
	[Audit Enabled] [nvarchar](255) NULL,
	[Field Security] [nvarchar](255) NULL,
	[Form Location] [nvarchar](255) NULL,
	[Additional data] [ntext] NULL,
	[Field Security - Accounting] [nvarchar](255) NULL,
	[Field Security - Compliance] [nvarchar](255) NULL,
	[Field Security - Customer Service Manager] [nvarchar](255) NULL,
	[Field Security - Customer Service Rep] [nvarchar](255) NULL,
	[Field Security - Data Reporting Specialist] [nvarchar](255) NULL,
	[Field Security - Executive] [nvarchar](255) NULL,
	[Field Security - Inside Sales] [nvarchar](255) NULL,
	[Field Security - Marketing] [nvarchar](255) NULL,
	[Field Security - Onboarding] [nvarchar](255) NULL,
	[Field Security - Sales] [nvarchar](255) NULL,
	[Field Security - Sales Admin] [nvarchar](255) NULL,
	[Field Security - Sales Manager] [nvarchar](255) NULL,
	[Field Security - System Administrator] [nvarchar](255) NULL,
	[Field Security - Team (Read + Activities)] [nvarchar](255) NULL,
	[Field Security - Team (Read Only)] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
