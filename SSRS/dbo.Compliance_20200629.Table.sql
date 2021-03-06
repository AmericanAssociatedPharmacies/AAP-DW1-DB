USE [SSRS]
GO
/****** Object:  Table [dbo].[Compliance_20200629]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Compliance_20200629](
	[GPI] [varchar](20) NULL,
	[Description] [varchar](250) NULL,
	[Purchase Qty] [decimal](19, 2) NULL,
	[Purchases @ IP] [decimal](19, 2) NULL,
	[Dispense Qty] [decimal](18, 2) NULL,
	[Dispense @ IP] [decimal](18, 2) NOT NULL,
	[Leakage Quantity] [decimal](20, 2) NULL,
	[Leakage @ IP] [decimal](20, 2) NULL
) ON [PRIMARY]
GO
