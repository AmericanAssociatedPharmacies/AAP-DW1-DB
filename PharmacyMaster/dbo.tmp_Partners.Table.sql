USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_Partners]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Partners](
	[VendorID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [varchar](150) NOT NULL,
	[RebateReportDisplayName] [varchar](255) NULL,
	[PPVendorID] [int] NULL
) ON [PRIMARY]
GO
