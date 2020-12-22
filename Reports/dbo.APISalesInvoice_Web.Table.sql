USE [Reports]
GO
/****** Object:  Table [dbo].[APISalesInvoice_Web]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APISalesInvoice_Web](
	[WHAccountid] [varchar](32) NULL,
	[InvNbr] [varchar](32) NULL,
	[InvDate] [datetime] NULL,
	[OrderNbr] [varchar](15) NULL,
	[CarrierCode] [varchar](15) NULL,
	[CarrierDesc] [varchar](255) NULL,
	[Whsnum] [varchar](2) NULL,
	[Whsname] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
