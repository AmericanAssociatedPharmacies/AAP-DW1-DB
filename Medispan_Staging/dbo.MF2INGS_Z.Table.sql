USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2INGS_Z]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2INGS_Z](
	[Ingredient_Set_ID] [numeric](19, 0) NOT NULL,
	[Ingredient_Indentifier] [numeric](19, 0) NOT NULL,
	[ActiveInactive_Ingredient_Flag] [nvarchar](1) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Reserve] [nvarchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ingredient_Set_ID] ASC,
	[Ingredient_Indentifier] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
