USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[Partners]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partners](
	[VendorID] [int] IDENTITY(1,1) NOT NULL,
	[VendorName] [varchar](150) NOT NULL,
	[RebateReportDisplayName] [varchar](255) NULL,
	[PPVendorID] [int] NULL,
 CONSTRAINT [PK_Partners] PRIMARY KEY CLUSTERED 
(
	[VendorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
