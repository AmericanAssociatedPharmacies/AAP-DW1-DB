USE [WebDev]
GO
/****** Object:  Table [dbo].[delete_ESICred061715]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delete_ESICred061715](
	[CHAIN] [nvarchar](255) NULL,
	[Territory] [nvarchar](255) NULL,
	[Chain Code] [float] NULL,
	[AAP#] [nvarchar](255) NULL,
	[NPI] [nvarchar](255) NULL,
	[NCPDP] [nvarchar](255) NULL,
	[PHARMACY NAME] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[MembershipOwner] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Fax] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Address2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[County] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Mailing Address] [nvarchar](255) NULL
) ON [PRIMARY]
GO
