USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2STR_1]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2STR_1](
	[Ingredient_Indentifier] [numeric](19, 0) NOT NULL,
	[Reserve_1] [nvarchar](2) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Ingredient_Drug_ID] [bigint] NULL,
	[Ingredient_Strength_Value] [real] NULL,
	[Ingredient_Strength_UOMcombin] [nvarchar](11) NULL,
	[Ingredient_Strength_UOMindivi] [nvarchar](11) NULL,
	[Volume_Value] [real] NULL,
	[Volume_Unit_of_Measure] [nvarchar](11) NULL,
	[Reserve_2] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ingredient_Indentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
