USE [WebDev]
GO
/****** Object:  Table [dbo].[DIRFeesSummary]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRFeesSummary](
	[Plan PBM] [nvarchar](50) NULL,
	[# of Claims] [nvarchar](50) NULL,
	[Total DIR] [nvarchar](50) NULL,
	[DIR or Fee] [nvarchar](50) NULL,
	[Plans Included ] [nvarchar](50) NULL,
	[Program Info  Link] [nvarchar](255) NULL,
	[Collection Schedule] [nvarchar](255) NULL,
	[DIR Fee Basis per Qtr] [nvarchar](255) NULL
) ON [PRIMARY]
GO
