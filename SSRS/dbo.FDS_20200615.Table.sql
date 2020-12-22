USE [SSRS]
GO
/****** Object:  Table [dbo].[FDS_20200615]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDS_20200615](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[Dispense Qty] [numeric](38, 3) NULL,
	[QuantityDispensed] [numeric](38, 3) NULL,
	[Dispense @ IP] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
