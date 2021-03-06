USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CAHAWPNADACcomparisonforGER_20181101]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHAWPNADACcomparisonforGER_20181101](
	[CIN] [nvarchar](500) NULL,
	[Generic Name] [nvarchar](500) NULL,
	[NDC] [nvarchar](500) NULL,
	[Strength] [nvarchar](500) NULL,
	[Form] [nvarchar](500) NULL,
	[Size] [nvarchar](500) NULL,
	[Mfr] [nvarchar](500) NULL,
	[Month-Year] [nvarchar](500) NULL,
	[AWP Unit] [nvarchar](500) NULL,
	[NADAC Unit] [nvarchar](500) NULL,
	[CAH Unit ] [nvarchar](500) NULL,
	[Ship Qty] [nvarchar](500) NULL,
	[Purchase Dollars] [nvarchar](500) NULL,
	[CurrentDate] [date] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NADACPrice_2] [money] NULL
) ON [PRIMARY]
GO
