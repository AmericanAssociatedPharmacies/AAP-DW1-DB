USE [SalesODS]
GO
/****** Object:  Table [Staging].[APISalesInvoice]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APISalesInvoice](
	[ID] [int] NOT NULL,
	[InvNbr] [varchar](32) NULL,
	[OrderNbr] [varchar](15) NULL,
	[InvDate] [datetime] NULL,
	[WHAccountID] [varchar](32) NULL,
	[CustomerName] [varchar](255) NULL,
	[CarrierCode] [varchar](15) NULL,
	[CarrierDesc] [varchar](255) NULL,
	[CustomerRef] [varchar](255) NULL,
	[Whsnum] [varchar](2) NULL,
	[OrdType] [varchar](2) NULL,
	[DateLoaded] [datetime] NULL,
	[RowCreatedDateETL] [datetime] NOT NULL,
 CONSTRAINT [PK_Staging_APISalesInvoice] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APISalesInvoice] ADD  DEFAULT (getdate()) FOR [RowCreatedDateETL]
GO
