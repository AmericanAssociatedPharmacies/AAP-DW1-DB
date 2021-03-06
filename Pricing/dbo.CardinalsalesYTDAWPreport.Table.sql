USE [Pricing]
GO
/****** Object:  Table [dbo].[CardinalsalesYTDAWPreport]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CardinalsalesYTDAWPreport](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
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
	[NADACPricePerUnit] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
 CONSTRAINT [CPK_CardinalsalesYTDAWPreport] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CardinalsalesYTDAWPreport] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
