USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PP1Q2010_Sales]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PP1Q2010_Sales](
	[PMID] [float] NULL,
	[AAP#] [varchar](20) NULL,
	[Parent #] [varchar](20) NULL,
	[UD #] [nvarchar](255) NULL,
	[API#] [varchar](20) NULL,
	[Account Name] [varchar](65) NULL,
	[city] [varchar](50) NULL,
	[state] [varchar](2) NULL,
	[territory] [varchar](4) NULL,
	[affiliate] [varchar](125) NULL,
	[Contact] [varchar](255) NULL,
	[Volume] [float] NULL,
	[Payment] [float] NULL
) ON [PRIMARY]
GO
