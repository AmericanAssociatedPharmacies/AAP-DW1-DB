USE [Reports]
GO
/****** Object:  Table [Staging].[APISalesUnaudited_Monthly]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APISalesUnaudited_Monthly](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[PMID] [int] NOT NULL,
	[APIAccountNo] [varchar](15) NULL,
	[GenericSales] [money] NULL,
	[BrandSales] [money] NULL,
	[OTCSales] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[GenericSalesTier1] [money] NOT NULL,
	[GenericSalesTier2] [money] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
 CONSTRAINT [CPK_Staging_APISalesUnaudited_Monthly] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APISalesUnaudited_Monthly] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[APISalesUnaudited_Monthly] ADD  DEFAULT ((0.00)) FOR [GenericSalesTier1]
GO
ALTER TABLE [Staging].[APISalesUnaudited_Monthly] ADD  DEFAULT ((0.00)) FOR [GenericSalesTier2]
GO
