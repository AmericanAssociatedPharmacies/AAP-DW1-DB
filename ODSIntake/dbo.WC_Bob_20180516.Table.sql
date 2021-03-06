USE [ODSIntake]
GO
/****** Object:  Table [dbo].[WC_Bob_20180516]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WC_Bob_20180516](
	[APIAccountNumber] [nvarchar](255) NULL,
	[StoreName] [nvarchar](255) NULL,
	[API Start Date] [nvarchar](255) NULL,
	[Sales] [money] NULL,
	[Purchasing Days] [float] NULL,
	[Buying Opporutnity Days] [float] NULL,
	[BuyingFreq] [float] NULL,
	[BizDay Rate] [money] NULL,
	[Forecast as of 4/24/18] [money] NULL,
	[F10] [nvarchar](255) NULL,
	[Forecast as of 5/15/18] [money] NULL,
	[F12] [nvarchar](255) NULL,
	[Difference] [money] NULL,
	[F14] [nvarchar](255) NULL,
	[Contacted] [nvarchar](255) NULL,
	[F16] [nvarchar](255) NULL,
	[Member] [nvarchar](255) NULL
) ON [PRIMARY]
GO
