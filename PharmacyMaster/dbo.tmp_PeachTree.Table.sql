USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PeachTree]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PeachTree](
	[pmid] [int] NOT NULL,
	[Corpname] [varchar](100) NULL,
	[address] [varchar](100) NULL,
	[address2] [varchar](100) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[zip] [varchar](50) NULL,
	[1099Type] [varchar](1) NOT NULL,
	[phone] [varchar](50) NULL,
	[fax] [varchar](50) NULL,
	[email] [varchar](80) NULL,
	[GLExpenseAccount] [varchar](7) NOT NULL,
	[FedID] [varchar](12) NULL,
	[1099Setting] [varchar](1) NOT NULL
) ON [PRIMARY]
GO
