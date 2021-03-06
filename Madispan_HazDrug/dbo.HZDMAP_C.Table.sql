USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[HZDMAP_C]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HZDMAP_C](
	[Concept_ID] [varchar](30) NOT NULL,
	[Concept_Type] [int] NOT NULL,
	[Class_ID] [int] NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Concept_Name] [nvarchar](500) NULL,
	[Reserve] [nvarchar](65) NULL,
PRIMARY KEY CLUSTERED 
(
	[Concept_ID] ASC,
	[Concept_Type] ASC,
	[Class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
