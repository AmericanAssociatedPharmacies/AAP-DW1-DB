USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PPRebates_Journal]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PPRebates_Journal](
	[Vendor ID] [int] NULL,
	[Invoice #] [varchar](6) NOT NULL,
	[Date] [varchar](9) NOT NULL,
	[Date Due] [varchar](8) NOT NULL,
	[Accounts Payable Account] [varchar](7) NOT NULL,
	[Number Of Distributions] [int] NOT NULL,
	[GL Account] [varchar](7) NOT NULL,
	[Amount] [numeric](8, 2) NULL,
	[Recur Number] [int] NOT NULL,
	[Recur Frequency] [int] NOT NULL
) ON [PRIMARY]
GO
