USE [API]
GO
/****** Object:  Table [dbo].[APISalesDetail_RSE_20180822]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APISalesDetail_RSE_20180822](
	[ID] [int] NOT NULL,
	[Rebate] [decimal](18, 2) NULL,
	[APIHoldBackPercent] [decimal](18, 4) NULL,
	[APIHoldBackAmount] [money] NULL,
	[RebateAfterAPIHoldbackAmount] [money] NULL,
	[AffiliateHoldbackPercent] [decimal](18, 4) NULL,
	[AffiliateHoldbackAmount] [money] NULL,
	[FinalRebateAmount] [money] NULL,
 CONSTRAINT [CPK_1_20180822] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
