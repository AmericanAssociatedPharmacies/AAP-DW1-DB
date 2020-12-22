USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ABC_20170908]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABC_20170908](
	[ABCItemNum] [nvarchar](255) NULL,
	[NDC] [nvarchar](255) NULL,
	[ABCInvoicePrice] [money] NULL,
	[F4] [nvarchar](255) NULL,
	[F5] [nvarchar](255) NULL
) ON [PRIMARY]
GO
