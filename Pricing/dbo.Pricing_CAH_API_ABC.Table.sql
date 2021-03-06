USE [Pricing]
GO
/****** Object:  Table [dbo].[Pricing_CAH_API_ABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pricing_CAH_API_ABC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[GPPC] [varchar](25) NULL,
	[GPI] [varchar](25) NULL,
	[Description] [varchar](500) NULL,
	[Size] [varchar](50) NULL,
	[API_ItemNumber] [varchar](50) NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[CAHItemNumber] [varchar](50) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[ABCInvoicePrice] [money] NULL,
	[CAHContractType] [varchar](250) NULL,
	[RowCreateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Pricing_CAH_API_ABC] ADD  DEFAULT (getdate()) FOR [RowCreateDate]
GO
