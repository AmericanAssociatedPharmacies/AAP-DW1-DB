USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_import_QPSRx30_090110]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_import_QPSRx30_090110](
	[PMID] [float] NULL,
	[Pharm ID] [float] NULL,
	[Store Name] [nvarchar](255) NULL,
	[Total Sales] [float] NULL,
	[ClaimsCount] [float] NULL,
	[Total Paid] [float] NULL,
	[TotalSales-TotalPaid] [float] NULL
) ON [PRIMARY]
GO
