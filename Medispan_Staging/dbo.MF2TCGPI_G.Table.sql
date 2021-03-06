USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2TCGPI_G]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2TCGPI_G](
	[TC_GPI_Key] [varchar](14) NOT NULL,
	[Record_Type_Code] [varchar](1) NOT NULL,
	[TC_GPI_Name] [nvarchar](60) NULL,
	[TC_Level_Code] [nvarchar](2) NULL,
	[Reserve] [nvarchar](10) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[TC_GPI_Key] ASC,
	[Record_Type_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
