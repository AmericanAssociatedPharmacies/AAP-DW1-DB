USE [SSRS]
GO
/****** Object:  Table [dbo].[PPP_Affiliate_API_CAH]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PPP_Affiliate_API_CAH](
	[Date] [datetime] NULL,
	[CAH Brand] [float] NULL,
	[CAH Generics] [money] NULL,
	[CAH Totals] [money] NULL,
	[API Brand] [money] NULL,
	[API Generic] [money] NULL,
	[API OTC] [money] NULL,
	[API Total] [money] NULL,
	[Grand Total] [money] NULL
) ON [PRIMARY]
GO
