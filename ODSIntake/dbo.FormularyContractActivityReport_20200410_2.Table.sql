USE [ODSIntake]
GO
/****** Object:  Table [dbo].[FormularyContractActivityReport_20200410_2]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormularyContractActivityReport_20200410_2](
	[ItemNbr] [varchar](500) NULL,
	[ChangeType] [varchar](500) NULL,
	[Description] [varchar](500) NULL,
	[Form] [varchar](500) NULL,
	[Unit] [varchar](500) NULL,
	[Supplier] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[OldPrice] [varchar](500) NULL,
	[NewPrice] [varchar](500) NULL,
	[OldPricePerDose] [varchar](500) NULL,
	[NewPricePerDose] [varchar](500) NULL,
	[WAC] [varchar](500) NULL,
	[BrandName] [varchar](500) NULL,
	[ReasonCode] [varchar](500) NULL,
	[EffectiveDate] [varchar](500) NULL,
	[Usage] [varchar](500) NULL,
	[GCN] [varchar](500) NULL,
	[Size] [varchar](500) NULL
) ON [PRIMARY]
GO
