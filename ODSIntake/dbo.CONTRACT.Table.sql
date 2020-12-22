USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CONTRACT]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTRACT](
	[show] [bit] NOT NULL,
	[ID] [int] NOT NULL,
	[delete] [bit] NOT NULL,
	[Contract Status] [nvarchar](255) NULL,
	[Contract Status 2] [nvarchar](255) NULL,
	[Control Rx] [bit] NOT NULL,
	[API Item #] [nvarchar](255) NULL,
	[REPLACE#] [nvarchar](50) NULL,
	[NDC #] [nvarchar](12) NULL,
	[Brand Reference] [nvarchar](255) NULL,
	[Item Description] [nvarchar](255) NULL,
	[Unit] [nvarchar](255) NULL,
	[Size] [decimal](8, 2) NULL,
	[Contract] [nvarchar](255) NULL,
	[Program] [nvarchar](255) NULL,
	[Rate] [nvarchar](255) NULL,
	[Invoice Price] [money] NULL,
	[DISCOUNT-RX PRICE] [money] NULL,
	[BW Contract Price] [money] NULL,
	[Contract Price] [money] NULL,
	[API Price] [money] NULL,
	[AWP] [money] NULL,
	[Net Price] [money] NULL,
	[Rebate] [money] NULL,
	[% Rebate] [float] NULL,
	[case pk] [int] NULL,
	[inner pk] [int] NULL,
	[Fee] [nvarchar](255) NULL,
	[MFG Date] [nvarchar](255) NULL,
	[API Date] [datetime] NULL,
	[billable size] [nvarchar](50) NULL,
	[billable cost] [nvarchar](50) NULL,
	[4% of price] [nvarchar](255) NULL,
	[rebate minus 4% of price] [nvarchar](255) NULL
) ON [PRIMARY]
GO
