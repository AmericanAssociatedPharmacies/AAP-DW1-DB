USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDS_20200110]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDS_20200110](
	[PMID] [int] NOT NULL,
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[AWPPerDose] [numeric](13, 5) NULL,
	[QuantityDispensed] [decimal](10, 3) NULL,
	[IsGeneric] [int] NOT NULL,
	[PrescriptionNumber] [varchar](100) NULL,
	[RefillNumber] [int] NULL,
	[TransactionDate] [datetime] NULL,
	[NDC] [varchar](11) NULL,
	[Is340BClaim] [bit] NULL
) ON [PRIMARY]
GO
