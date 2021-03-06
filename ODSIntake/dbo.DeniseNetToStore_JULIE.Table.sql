USE [ODSIntake]
GO
/****** Object:  Table [dbo].[DeniseNetToStore_JULIE]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeniseNetToStore_JULIE](
	[NDC #] [nvarchar](255) NULL,
	[API ITEM #] [nvarchar](255) NULL,
	[ITEM DESCRIPTION] [nvarchar](255) NULL,
	[UNIT] [nvarchar](255) NULL,
	[SIZE] [nvarchar](255) NULL,
	[CONTRACT] [nvarchar](255) NULL,
	[API PRICE] [money] NULL,
	[Store Net] [numeric](28, 4) NULL,
	[Adj Rebate] [numeric](28, 4) NULL,
	[Store Adj Net] [numeric](28, 4) NULL,
	[PROGRAM] [nvarchar](255) NULL
) ON [PRIMARY]
GO
