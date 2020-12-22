USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_equipp]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_equipp](
	[NCPDP] [varchar](20) NULL,
	[AccountName] [varchar](65) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[InEquipp] [varchar](3) NOT NULL,
	[Affiliate] [varchar](125) NULL
) ON [PRIMARY]
GO
