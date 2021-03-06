USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CAH_FormularyFile_TenSourceGeneric]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CAH_FormularyFile_TenSourceGeneric](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NULL,
	[CIN] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Size] [varchar](500) NULL,
	[AAP Sell] [varchar](500) NULL,
	[Supplier] [varchar](500) NULL,
	[Brand Name] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[NDC/UPC] [varchar](500) NULL,
	[DP#] [varchar](500) NULL,
	[UOM] [varchar](500) NULL,
	[Price Per Unit] [varchar](500) NULL,
	[GPI_ID] [varchar](500) NULL,
	[GCN] [varchar](500) NULL,
	[GCN SEQ] [varchar](500) NULL,
	[Color] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[CorrectedNDCUPC] [varchar](500) NULL,
 CONSTRAINT [CPK_Staging_CAH_FormularyFile_TenSourceGeneric] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CAH_FormularyFile_TenSourceGeneric] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
