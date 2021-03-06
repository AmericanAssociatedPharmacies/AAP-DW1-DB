USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CAH_FormularyFile_2]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAH_FormularyFile_2](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NULL,
	[DateKey] [int] NULL,
	[CAHFileType] [varchar](500) NULL,
	[CIN] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Size] [varchar](500) NULL,
	[AAPSell] [varchar](500) NULL,
	[Supplier] [varchar](500) NULL,
	[BrandName] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[NDCUPC] [varchar](500) NULL,
	[DPNum] [varchar](500) NULL,
	[UOM] [varchar](500) NULL,
	[PricePerUnit] [varchar](500) NULL,
	[GPIID] [varchar](500) NULL,
	[GCN] [varchar](500) NULL,
	[GCNSEQ] [varchar](500) NULL,
	[Color] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[CorrectedNDCUPC] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
