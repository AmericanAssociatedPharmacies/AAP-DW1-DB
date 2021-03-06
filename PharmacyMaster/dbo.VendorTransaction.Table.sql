USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[VendorTransaction]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorTransaction](
	[TransactionID] [int] IDENTITY(1001,1) NOT NULL,
	[PaidDt] [smalldatetime] NULL,
	[VendorID] [int] NULL,
 CONSTRAINT [PK_VendorTransaction] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
