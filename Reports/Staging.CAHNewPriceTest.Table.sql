USE [Reports]
GO
/****** Object:  Table [Staging].[CAHNewPriceTest]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAHNewPriceTest](
	[VendorName] [varchar](50) NULL,
	[CIN] [varchar](50) NOT NULL,
	[NDC] [varchar](50) NULL,
	[Description] [varchar](80) NULL,
	[CurrentSell] [float] NULL,
	[NewInvoice] [float] NULL,
	[usage] [float] NULL,
	[CurrentExtSell] [float] NULL,
	[NewExtSell] [float] NULL,
	[Variance] [float] NULL
) ON [PRIMARY]
GO
