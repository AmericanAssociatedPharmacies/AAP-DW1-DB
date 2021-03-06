USE [Reports]
GO
/****** Object:  Table [Staging].[GenericLoyaltyTrend_WorkTable]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[GenericLoyaltyTrend_WorkTable](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[Year] [int] NOT NULL,
	[1stQrtr] [money] NULL,
	[2ndQrtr] [money] NULL,
	[3rdQrtr] [money] NULL,
	[4thQrtr] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_GenericLoyaltyTrend_WorkTable] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[GenericLoyaltyTrend_WorkTable] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
