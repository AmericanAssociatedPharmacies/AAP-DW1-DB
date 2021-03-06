USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Compare_Julie]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compare_Julie](
	[NDC] [nvarchar](255) NULL,
	[Ship Qty] [nvarchar](255) NULL,
	[Store Price] [money] NULL,
	[descr] [nvarchar](255) NULL,
	[Tier] [nvarchar](255) NULL,
	[GPI] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[API #] [nvarchar](255) NULL,
	[Desc] [nvarchar](255) NULL,
	[API Price] [money] NULL,
	[Adj Reb] [money] NULL,
	[Cah Price] [money] NULL,
	[CIN] [nvarchar](255) NULL
) ON [PRIMARY]
GO
