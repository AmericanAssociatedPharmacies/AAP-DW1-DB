USE [CAHODS]
GO
/****** Object:  Table [dbo].[CAH_FormularyFile]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAH_FormularyFile](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NULL,
	[DateKey] [int] NULL,
	[CAHFileType] [varchar](500) NULL,
	[CIN] [varchar](25) NULL,
	[Description] [varchar](255) NULL,
	[Size] [varchar](50) NULL,
	[AAPSell] [money] NULL,
	[Supplier] [varchar](250) NULL,
	[BrandName] [varchar](250) NULL,
	[Form] [varchar](250) NULL,
	[NDCUPC] [varchar](11) NULL,
	[DPNum] [varchar](250) NULL,
	[UOM] [varchar](250) NULL,
	[PricePerUnit] [money] NULL,
	[GPIID] [varchar](2500) NULL,
	[GCN] [varchar](250) NULL,
	[GCNSEQ] [varchar](250) NULL,
	[Color] [varchar](250) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[CorrectedNDCUPC] [varchar](11) NULL,
	[IsBackupSource] [bit] NOT NULL,
	[IsTenSource] [bit] NOT NULL,
	[IsSourceWeekly] [bit] NOT NULL,
	[IsTopGenerics] [bit] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_CAH_FormularyFile] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAH_FormularyFile] ADD  DEFAULT ((0)) FOR [IsBackupSource]
GO
ALTER TABLE [dbo].[CAH_FormularyFile] ADD  DEFAULT ((0)) FOR [IsTenSource]
GO
ALTER TABLE [dbo].[CAH_FormularyFile] ADD  DEFAULT ((0)) FOR [IsSourceWeekly]
GO
ALTER TABLE [dbo].[CAH_FormularyFile] ADD  DEFAULT ((0)) FOR [IsTopGenerics]
GO
ALTER TABLE [dbo].[CAH_FormularyFile] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
