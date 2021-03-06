USE [Medispan]
GO
/****** Object:  Table [dbo].[M25_S]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25_S](
	[NDC_UPC_HRI] [varchar](11) NULL,
	[ID_Number_Format_Code] [varchar](1) NULL,
	[Record_Code] [varchar](1) NULL,
	[Record_Code_ID] [numeric](37, 0) NULL,
	[Transaction_Code] [varchar](1) NULL,
	[Reserve_1] [varchar](1) NULL,
	[DP_Package_Price] [numeric](10, 2) NULL,
	[DP_Unit_Price] [numeric](13, 5) NULL,
	[DP_Effective_Date] [smalldatetime] NULL,
	[Older_DP_Package_Price] [numeric](10, 2) NULL,
	[Older_DP_Unit_Price] [numeric](13, 5) NULL,
	[Older_DP_Effective_Date] [smalldatetime] NULL,
	[Reserve_2] [varchar](16) NULL,
	[Last_Change_Date] [varchar](5) NULL
) ON [PRIMARY]
GO
