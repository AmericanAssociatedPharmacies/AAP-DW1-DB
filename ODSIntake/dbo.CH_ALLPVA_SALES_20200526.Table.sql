USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CH_ALLPVA_SALES_20200526]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CH_ALLPVA_SALES_20200526](
	[Date] [datetime2](3) NULL,
	[PMID] [int] NULL,
	[NetSourceGenerics] [money] NOT NULL
) ON [PRIMARY]
GO
