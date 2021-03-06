USE [ODSIntake]
GO
/****** Object:  Table [dbo].[FormularyContractActivityReport_20200410]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormularyContractActivityReport_20200410](
	[ItemNbr] [varchar](50) NULL,
	[ChangeType] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[Form] [varchar](50) NULL,
	[Unit] [varchar](50) NULL,
	[Supplier] [varchar](50) NULL,
	[NDC] [varchar](50) NULL,
	[OldPrice] [varchar](50) NULL,
	[NewPrice] [varchar](50) NULL,
	[OldPricePerDose] [varchar](50) NULL,
	[NewPricePerDose] [varchar](50) NULL,
	[WAC] [varchar](50) NULL,
	[BrandName] [varchar](50) NULL,
	[ReasonCode] [varchar](50) NULL,
	[EffectiveDate] [varchar](50) NULL,
	[Usage] [varchar](50) NULL,
	[GCN] [varchar](50) NULL,
	[Size] [varchar](50) NULL
) ON [PRIMARY]
GO
