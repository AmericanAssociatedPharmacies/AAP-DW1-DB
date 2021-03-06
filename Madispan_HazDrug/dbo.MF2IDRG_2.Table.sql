USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2IDRG_2]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2IDRG_2](
	[Ingredient_Drug_ID] [numeric](19, 0) NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[CAS_Number] [nvarchar](20) NULL,
	[Knowledge_Base_Drug_Code_7] [bigint] NULL,
	[Reserve_1] [nvarchar](3) NULL,
	[Ingredient_Drug_Name] [nvarchar](60) NULL,
	[Generic_ID] [nvarchar](10) NULL,
	[Reserve_2] [nvarchar](17) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ingredient_Drug_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
