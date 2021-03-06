USE [Reports]
GO
/****** Object:  Table [dbo].[GenericLoyaltyTrend]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GenericLoyaltyTrend](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[CurrentGenericSales] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_GenericLoyaltyTrend_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GenericLoyaltyTrend] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
