USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[TopGenerics053111]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TopGenerics053111](
	[Description] [nvarchar](255) NULL,
	[Size] [nvarchar](60) NULL,
	[Supplier] [nvarchar](255) NULL,
	[AWP] [money] NULL,
	[AAP Top Generics Sell Price] [money] NULL,
	[AAP Top Generics Price Per Unit] [money] NULL,
	[Brand Name] [varchar](255) NULL,
	[Form] [varchar](60) NULL,
	[Color] [varchar](60) NULL,
	[NDC/UPC] [varchar](15) NULL,
	[CIN] [varchar](15) NULL,
	[DP#] [varchar](15) NULL,
	[GPI_ID] [varchar](14) NULL,
	[GCN] [varchar](6) NULL,
	[GCN SEQNO] [varchar](6) NULL
) ON [PRIMARY]
GO
