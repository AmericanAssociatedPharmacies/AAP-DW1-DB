USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Nova_20180801]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nova_20180801](
	[NDC] [nvarchar](255) NULL,
	[CIN] [nvarchar](255) NULL,
	[Desc] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[Quantity] [float] NULL,
	[AAP Price] [money] NULL,
	[AAP Ext] [money] NULL,
	[Comp Price] [money] NULL,
	[Comp Ext] [money] NULL
) ON [PRIMARY]
GO
