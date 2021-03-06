USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CardinalOTC_File3]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardinalOTC_File3](
	[NDC] [nvarchar](255) NULL,
	[Order Qty] [float] NULL,
	[Return Qty] [float] NULL,
	[Ship Qty] [float] NULL,
	[Dollars] [money] NULL,
	[Trade Name] [nvarchar](255) NULL,
	[Generic Name] [nvarchar](255) NULL,
	[CIN] [nvarchar](255) NULL,
	[Mfr] [nvarchar](255) NULL,
	[Strength] [nvarchar](255) NULL,
	[Form] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[Contract Indicator] [nvarchar](255) NULL
) ON [PRIMARY]
GO
