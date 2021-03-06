USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CardCom_20171023]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardCom_20171023](
	[Customer] [varchar](63) NULL,
	[API ITEM] [nvarchar](50) NULL,
	[APINDC] [nvarchar](20) NULL,
	[API PRICE] [decimal](28, 4) NULL,
	[APIExt] [decimal](38, 4) NULL,
	[Adj Rebate] [decimal](10, 3) NULL,
	[NDC] [varchar](15) NULL,
	[ItemDesc] [varchar](255) NULL,
	[FDB_PKG_SIZE] [decimal](8, 3) NULL,
	[SHIP_QTY] [decimal](38, 0) NULL,
	[Unit_Cost] [float] NULL,
	[Ext_Cost] [float] NULL,
	[DrugType] [varchar](31) NULL
) ON [PRIMARY]
GO
