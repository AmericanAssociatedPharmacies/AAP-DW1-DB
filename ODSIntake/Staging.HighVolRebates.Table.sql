USE [ODSIntake]
GO
/****** Object:  Table [Staging].[HighVolRebates]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[HighVolRebates](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[PMID] [varchar](500) NULL,
	[AAPNumber] [varchar](500) NULL,
	[APIAccount] [varchar](500) NULL,
	[CustomerName] [varchar](500) NULL,
	[City] [varchar](500) NULL,
	[State] [varchar](500) NULL,
	[BsClass] [varchar](500) NULL,
	[Month] [varchar](500) NULL,
	[CurrentEstMonthlySales] [varchar](500) NULL,
	[MonthlyAPIVolume] [varchar](500) NULL,
	[CAHOffContractLTCVolume] [varchar](500) NULL,
	[AAPNetSales] [varchar](500) NULL,
	[MonthCombVolume] [varchar](500) NULL,
	[AAPSalesCOGApplied] [varchar](500) NULL,
	[AAPBrandRXSales] [varchar](500) NULL,
	[CurrentCACOG] [varchar](500) NULL,
	[Base] [varchar](500) NULL,
	[BrandRX_WAC] [varchar](500) NULL,
	[BrandRXSaved] [varchar](500) NULL,
	[HighVolumeIncentive] [varchar](500) NULL,
	[TotalSaved] [varchar](500) NULL,
	[ECOG] [varchar](500) NULL,
	[COGReduction] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[HighVolRebates] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
