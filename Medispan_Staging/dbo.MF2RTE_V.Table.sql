USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2RTE_V]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2RTE_V](
	[Concept_Type] [int] NOT NULL,
	[Country_Code] [int] NOT NULL,
	[Concept_ID] [numeric](19, 0) NOT NULL,
	[Transaction_CD] [nvarchar](1) NULL,
	[Status] [int] NULL,
	[Link_Value] [bigint] NULL,
	[Link_Date] [bigint] NULL,
	[Reserve] [nvarchar](11) NULL,
PRIMARY KEY CLUSTERED 
(
	[Concept_Type] ASC,
	[Country_Code] ASC,
	[Concept_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
