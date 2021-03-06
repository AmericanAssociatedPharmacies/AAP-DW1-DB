USE [Pricing]
GO
/****** Object:  Table [Staging].[CAH_FormularyFiles_BackupSource]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAH_FormularyFiles_BackupSource](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Datekey] [int] NULL,
	[CIN] [varchar](25) NULL,
	[Description] [varchar](255) NULL,
	[Size] [varchar](255) NULL,
	[AAP Sell] [money] NULL,
	[Supplier] [varchar](255) NULL,
	[Brand Name] [varchar](255) NULL,
	[Form] [varchar](255) NULL,
	[NDC/UPC] [varchar](25) NULL,
	[DP#] [varchar](25) NULL,
	[UOM] [varchar](255) NULL,
	[Price Per Unit] [money] NULL,
	[GPI_ID] [varchar](255) NULL,
	[GCN] [varchar](255) NULL,
	[GCN SEQ] [varchar](25) NULL,
	[Color] [varchar](255) NULL,
	[FileProcesed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_CAH_FormularyFiles_BackupSource] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CAH_FormularyFiles_BackupSource] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
