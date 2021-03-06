USE [Medispan]
GO
/****** Object:  Table [dbo].[M25_T]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25_T](
	[NDC_UPC_HRI] [varchar](11) NULL,
	[ID_Number_Format_Code] [varchar](1) NULL,
	[Record_Code] [varchar](1) NULL,
	[Record_Code_ID] [numeric](37, 0) NULL,
	[Transaction_Code] [varchar](1) NULL,
	[Reserve_1] [varchar](1) NULL,
	[CMS_FUL_Price] [numeric](13, 5) NULL,
	[CMS_FUL_Price_Eff_Date] [smalldatetime] NULL,
	[first_Oldest_CMS_FUL_Price] [numeric](13, 5) NULL,
	[first_Oldest_CMS_FUL_Eff_Dt] [numeric](37, 0) NULL,
	[second_Oldest_CMS_FUL_Price] [numeric](13, 5) NULL,
	[second_Oldest_CMS_FUL_Eff_Dt] [numeric](37, 0) NULL,
	[Reserve_2] [varchar](15) NULL,
	[Last_Change_Date] [varchar](5) NULL
) ON [PRIMARY]
GO
