USE [Reports]
GO
/****** Object:  Table [Staging].[ComplianceAllStoresFDS]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ComplianceAllStoresFDS](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[MonthDate] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NOT NULL,
	[TotalQuantityDispensed] [decimal](18, 2) NOT NULL,
	[GenericQuantityDispensed] [decimal](18, 2) NOT NULL,
	[BrandQuantityDispensed] [decimal](18, 2) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NOT NULL,
	[GPIKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
 CONSTRAINT [CPK_Staging_ComplianceAllStoresFDS] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_Staging_ComplianceAllStoresFDS] UNIQUE NONCLUSTERED 
(
	[DateKey] ASC,
	[GPIKey] ASC,
	[PharmacyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ComplianceAllStoresFDS] ADD  DEFAULT ((0.00)) FOR [TotalQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStoresFDS] ADD  DEFAULT ((0.00)) FOR [GenericQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStoresFDS] ADD  DEFAULT ((0.00)) FOR [BrandQuantityDispensed]
GO
ALTER TABLE [Staging].[ComplianceAllStoresFDS] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
