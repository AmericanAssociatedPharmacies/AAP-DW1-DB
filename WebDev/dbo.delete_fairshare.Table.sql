USE [WebDev]
GO
/****** Object:  Table [dbo].[delete_fairshare]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delete_fairshare](
	[CustNum] [nvarchar](255) NULL,
	[ProdNum] [nvarchar](255) NULL,
	[ProdDesc] [nvarchar](255) NULL,
	[Count] [nvarchar](255) NULL,
	[Price] [money] NULL,
	[Monthly Qty] [float] NULL,
	[Requested Qty] [nvarchar](255) NULL,
	[Start Date] [datetime] NULL,
	[End Date] [datetime] NULL,
	[Last Updated] [nvarchar](255) NULL,
	[NDC] [nvarchar](255) NULL,
	[Expiration Date] [nvarchar](255) NULL
) ON [PRIMARY]
GO
