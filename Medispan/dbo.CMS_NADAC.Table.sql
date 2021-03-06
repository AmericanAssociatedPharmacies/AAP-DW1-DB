USE [Medispan]
GO
/****** Object:  Table [dbo].[CMS_NADAC]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CMS_NADAC](
	[NDC_Description] [varchar](100) NULL,
	[NDC] [char](11) NULL,
	[NADAC_per_unit] [float] NULL,
	[effective_date] [smalldatetime] NULL,
	[pricing_unit] [char](4) NULL,
	[pharmachy_type_indicator] [varchar](3) NULL,
	[OTC] [char](2) NULL,
	[ExplanationCode] [varchar](10) NULL,
	[classification_for_rate_setting] [char](2) NULL,
	[Corresponding_generic_drug_nadac_per_unit] [float] NULL,
	[corresponding_generic_drug_effective_date] [smalldatetime] NULL,
	[dateloaded] [smalldatetime] NULL
) ON [PRIMARY]
GO
