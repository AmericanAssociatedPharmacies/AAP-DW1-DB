USE [Pricing]
GO
/****** Object:  Table [Staging].[MedispanPricing]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[MedispanPricing](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DrugKey] [int] NULL,
	[DateKey] [int] NULL,
	[NDC] [varchar](25) NULL,
	[AWP] [money] NULL,
	[DirectPrice] [money] NULL,
	[CMSFUL] [money] NULL,
	[WAC] [money] NULL,
	[AAWP] [money] NULL,
	[GEAP] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_MedispanPricing] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[MedispanPricing] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
