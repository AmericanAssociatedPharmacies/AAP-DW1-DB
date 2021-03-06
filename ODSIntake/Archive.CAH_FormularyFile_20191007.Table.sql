USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CAH_FormularyFile_20191007]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CAH_FormularyFile_20191007](
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
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_CAH_FormularyFile_20191007] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CAH_FormularyFile_20191007] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
