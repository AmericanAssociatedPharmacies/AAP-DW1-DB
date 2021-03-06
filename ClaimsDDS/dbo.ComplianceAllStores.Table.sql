USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[ComplianceAllStores]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComplianceAllStores](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NOT NULL,
	[TotalQuantityDispensed] [decimal](18, 2) NULL,
	[GenericQuantityDispensed] [decimal](18, 2) NULL,
	[BrandQuantityDispensed] [decimal](18, 2) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ComplianceAllStores] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComplianceAllStores] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
