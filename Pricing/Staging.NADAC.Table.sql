USE [Pricing]
GO
/****** Object:  Table [Staging].[NADAC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[NADAC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NDC] [varchar](13) NULL,
	[DrugKey] [int] NOT NULL,
	[PriceStartDateKey] [int] NOT NULL,
	[PriceEndDateKey] [int] NOT NULL,
	[NADACPricePerUnit] [money] NULL,
	[NADACPrice] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_NADAC_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[NADAC] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
