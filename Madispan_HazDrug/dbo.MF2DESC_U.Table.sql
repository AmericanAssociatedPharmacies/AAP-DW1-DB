USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2DESC_U]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2DESC_U](
	[Concept_Type] [int] NOT NULL,
	[Country_Code] [int] NOT NULL,
	[Concept_ID] [numeric](19, 0) NOT NULL,
	[Type_Code] [int] NOT NULL,
	[Transaction_CD] [nvarchar](1) NULL,
	[Description] [nvarchar](250) NULL,
	[Reserve] [nvarchar](67) NULL,
PRIMARY KEY CLUSTERED 
(
	[Concept_Type] ASC,
	[Country_Code] ASC,
	[Concept_ID] ASC,
	[Type_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
