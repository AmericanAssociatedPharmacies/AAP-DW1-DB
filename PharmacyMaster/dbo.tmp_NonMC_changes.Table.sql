USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_NonMC_changes]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_NonMC_changes](
	[AccountName] [varchar](100) NULL,
	[AAPAccountNo] [varchar](20) NULL,
	[NCPDP] [varchar](100) NULL,
	[ColumnNameChanged] [varchar](100) NULL,
	[ChangedFrom] [varchar](100) NULL,
	[ChangedTo] [varchar](100) NULL
) ON [PRIMARY]
GO
