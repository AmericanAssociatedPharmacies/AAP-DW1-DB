USE [ODSIntake]
GO
/****** Object:  Table [dbo].[NADAC_20171004]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NADAC_20171004](
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
	[As of Date] [varchar](500) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
