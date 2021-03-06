USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[SoftwareRxAplicor]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoftwareRxAplicor](
	[Account Code] [nvarchar](50) NULL,
	[Account Name] [nvarchar](255) NULL,
	[PMID] [nvarchar](50) NULL,
	[API Acct No] [nvarchar](50) NULL,
	[AAP Acct No] [nvarchar](50) NULL,
	[Rx Comp Sys] [nvarchar](255) NULL
) ON [PRIMARY]
GO
