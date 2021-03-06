USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RX30_MM_20180503]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RX30_MM_20180503](
	[PharmacyKey] [int] NULL,
	[DrugKey] [int] NOT NULL,
	[BINNumber] [varchar](25) NULL,
	[PrescriptionNumber] [varchar](25) NULL,
	[PayerName] [varchar](250) NULL,
	[QuantityDispensed] [decimal](10, 3) NULL,
	[RXDateFilled] [date] NULL,
	[UsualandCustomaryCharge] [money] NOT NULL,
	[RX30TotalPrice] [money] NOT NULL,
	[RX30ReimbursedPricePerUnit] [money] NULL,
	[TotalPharmacyPaid] [money] NOT NULL
) ON [PRIMARY]
GO
