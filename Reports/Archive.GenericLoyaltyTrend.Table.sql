USE [Reports]
GO
/****** Object:  Table [Archive].[GenericLoyaltyTrend]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[GenericLoyaltyTrend](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[Date] [datetime] NULL,
	[CurrentGenericSales] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
 CONSTRAINT [CPK_Archive_GenericLoyaltyTrend_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[GenericLoyaltyTrend] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
