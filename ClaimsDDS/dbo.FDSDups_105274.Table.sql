USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDSDups_105274]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDSDups_105274](
	[RN] [bigint] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[AWPPerDose] [numeric](13, 5) NULL,
	[QuantityDispensed] [numeric](38, 3) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsGeneric] [bit] NULL,
	[PrescriptionNumber] [varchar](100) NULL,
	[RefillNumber] [int] NULL,
	[TransactionDate] [date] NULL,
	[NDC] [varchar](13) NULL,
	[Is340BClaim] [bit] NULL
) ON [PRIMARY]
GO
