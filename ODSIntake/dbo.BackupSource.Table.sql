USE [ODSIntake]
GO
/****** Object:  Table [dbo].[BackupSource]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BackupSource](
	[CIN] [float] NULL,
	[Description] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[AAP Sell] [money] NULL,
	[Supplier] [nvarchar](255) NULL,
	[Brand Name] [nvarchar](255) NULL,
	[Form] [nvarchar](255) NULL,
	[NDC/UPC] [float] NULL,
	[DP#] [float] NULL,
	[UOM] [nvarchar](255) NULL,
	[Price Per Unit] [float] NULL,
	[GPI_ID] [nvarchar](255) NULL,
	[GCN] [nvarchar](255) NULL,
	[GCN SEQ] [float] NULL,
	[Color] [nvarchar](255) NULL
) ON [PRIMARY]
GO
