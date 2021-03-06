USE [Reports]
GO
/****** Object:  Table [dbo].[CAHNewPriceTest]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHNewPriceTest](
	[VendorName] [varchar](50) NULL,
	[CIN] [varchar](50) NULL,
	[NDC] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[CurrentSell] [varchar](50) NULL,
	[NewInvoice] [varchar](50) NULL,
	[usage] [varchar](50) NULL,
	[CurrentExtSell] [varchar](50) NULL,
	[NewExtSell] [varchar](50) NULL,
	[Variance] [varchar](50) NULL
) ON [PRIMARY]
GO
