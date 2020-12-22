USE [Reports]
GO
/****** Object:  Table [Archive].[GenericLoyaltyTrend_backup_RSE_20191230]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[GenericLoyaltyTrend_backup_RSE_20191230](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[Date] [datetime] NULL,
	[CurrentGenericSales] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL
) ON [PRIMARY]
GO
