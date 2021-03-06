USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[delete_SpecialtyActive101314_report]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delete_SpecialtyActive101314_report](
	[pmid] [int] NULL,
	[date_webrequest] [varchar](30) NULL,
	[software] [varchar](255) NULL,
	[contact] [varchar](255) NULL,
	[phone] [varchar](255) NULL,
	[email] [varchar](255) NULL,
	[Active] [varchar](3) NOT NULL,
	[active_ncpdp] [nvarchar](15) NULL,
	[rank] [bigint] NULL,
	[accountname] [varchar](65) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[date_pm_programs] [varchar](30) NULL
) ON [PRIMARY]
GO
