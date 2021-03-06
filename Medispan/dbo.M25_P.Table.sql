USE [Medispan]
GO
/****** Object:  Table [dbo].[M25_P]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25_P](
	[NDC_UPC_HRI] [varchar](11) NULL,
	[ID_Number_Format_Code] [varchar](1) NULL,
	[Record_Code] [varchar](1) NULL,
	[Record_Code_ID] [numeric](37, 0) NULL,
	[Transaction_Code] [varchar](1) NULL,
	[Ingredient_Generic_ID_Type_Co] [varchar](1) NULL,
	[Ingredient_Generic_ID_Number] [numeric](37, 0) NULL,
	[Ingredient_Strength] [numeric](13, 5) NULL,
	[Strength_Unit_Measure] [varchar](11) NULL,
	[Generic_Ingredient_Name] [varchar](40) NULL,
	[Active_Inactive_Ingredient_Fl] [varchar](1) NULL,
	[Reserve] [varchar](4) NULL,
	[Last_Change_Date] [varchar](5) NULL
) ON [PRIMARY]
GO
