USE [ODSIntake]
GO
/****** Object:  Table [Staging].[NADAC]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[NADAC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NULL,
	[NDCDescription] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[NADACPerUnit] [varchar](500) NULL,
	[EffectiveDate] [varchar](500) NULL,
	[PricingUnit] [varchar](500) NULL,
	[PharmacyTypeIndicator] [varchar](500) NULL,
	[OTC] [varchar](500) NULL,
	[ExplanationCode] [varchar](500) NULL,
	[ClassificationforRateSetting] [varchar](500) NULL,
	[CorrespondingGenericDrugNADACPerUnit] [varchar](500) NULL,
	[CorrespondingGenericDrugEffectiveDate] [varchar](500) NULL,
	[AsofDate] [varchar](500) NULL,
	[FileProcessed] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_NADAC] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[NADAC] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
