USE [ODSIntake]
GO
/****** Object:  Table [dbo].[NADAC__National_Average_Drug_Acquisition_Cost_]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NADAC__National_Average_Drug_Acquisition_Cost_](
	[NDC Description] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[NADAC_Per_Unit] [varchar](500) NULL,
	[Effective_Date] [varchar](500) NULL,
	[Pricing_Unit] [varchar](500) NULL,
	[Pharmacy_Type_Indicator] [varchar](500) NULL,
	[OTC] [varchar](500) NULL,
	[Explanation_Code] [varchar](500) NULL,
	[Classification_for_Rate_Setting] [varchar](500) NULL,
	[Corresponding_Generic_Drug_NADAC_Per_Unit] [varchar](500) NULL,
	[Corresponding_Generic_Drug_Effective_Date] [varchar](500) NULL,
	[As of Date] [varchar](500) NULL
) ON [PRIMARY]
GO
