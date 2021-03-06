USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_pm_pharmacists012916]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_pm_pharmacists012916](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[PharPrime] [smallint] NULL,
	[PharFullName] [varchar](255) NULL,
	[PharTitle] [varchar](20) NULL,
	[PharState] [varchar](2) NULL,
	[PharLicNo] [varchar](20) NULL,
	[PharExpDate] [datetime] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
