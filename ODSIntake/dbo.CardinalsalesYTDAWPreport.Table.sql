USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CardinalsalesYTDAWPreport]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardinalsalesYTDAWPreport](
	[CIN] [nvarchar](500) NULL,
	[Generic Name] [nvarchar](500) NULL,
	[Trade Name] [nvarchar](500) NULL,
	[NDC] [nvarchar](500) NULL,
	[Strength] [nvarchar](500) NULL,
	[Form] [nvarchar](500) NULL,
	[Size] [nvarchar](500) NULL,
	[Mfr] [nvarchar](500) NULL,
	[Month-Year] [nvarchar](500) NULL,
	[AWP] [nvarchar](500) NULL,
	[Unit Price ] [nvarchar](500) NULL,
	[Ship Qty] [nvarchar](500) NULL,
	[Purchase Dollars] [nvarchar](500) NULL,
	[NADACPricePerUnit] [money] NULL
) ON [PRIMARY]
GO
