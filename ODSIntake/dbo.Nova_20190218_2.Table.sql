USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Nova_20190218_2]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nova_20190218_2](
	[net qty] [varchar](500) NULL,
	[total] [varchar](500) NULL,
	[Unit Cost] [varchar](500) NULL,
	[name] [varchar](500) NULL,
	[name2] [varchar](500) NULL,
	[cin] [varchar](500) NULL,
	[mfr] [varchar](500) NULL,
	[strength] [varchar](500) NULL,
	[form] [varchar](500) NULL,
	[Size] [varchar](500) NULL,
	[on contract] [varchar](500) NULL,
	[CAH_NDC] [varchar](25) NULL,
	[CAHContractType] [varchar](50) NULL,
	[CardinalInvoicePrice] [money] NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL
) ON [PRIMARY]
GO
