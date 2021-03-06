USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[VendorLoad]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorLoad](
	[FileID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionID] [int] NULL,
	[FileName] [nvarchar](200) NULL,
	[LoadDate] [smalldatetime] NULL,
	[LoadedBy] [nvarchar](50) NULL,
 CONSTRAINT [PK_VendorLoad] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
