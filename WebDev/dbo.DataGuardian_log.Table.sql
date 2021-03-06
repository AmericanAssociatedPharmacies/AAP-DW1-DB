USE [WebDev]
GO
/****** Object:  Table [dbo].[DataGuardian_log]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataGuardian_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NULL,
	[dt] [datetime] NULL,
	[NCPDP] [varchar](15) NULL,
	[name] [varchar](255) NULL,
	[software] [varchar](255) NULL,
	[imagecapture] [int] NULL,
	[contact] [varchar](255) NULL,
	[contact_install] [varchar](255) NULL,
	[phone] [varchar](50) NULL,
	[email] [varchar](50) NULL,
	[NPI] [varchar](15) NULL,
	[HipaaOfficer] [varchar](255) NULL,
	[AAPID] [int] NULL,
	[address] [varchar](255) NULL,
	[hours] [varchar](255) NULL
) ON [PRIMARY]
GO
