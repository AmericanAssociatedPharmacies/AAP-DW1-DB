USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPA_List]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPA_List](
	[PMID] [nvarchar](50) NULL,
	[AAPAccountno] [nvarchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[AAPParentNo] [nvarchar](50) NULL,
	[ncpaid] [nvarchar](50) NULL,
	[membertype] [nvarchar](50) NULL,
	[paidthru] [nvarchar](50) NULL,
	[sourcecode] [nvarchar](50) NULL,
	[NCPDP] [nvarchar](50) NULL,
	[Accountname] [nvarchar](50) NULL,
	[Addr1] [nvarchar](50) NULL,
	[Addr2] [nvarchar](50) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Zip] [nvarchar](50) NULL,
	[phone] [nvarchar](50) NULL,
	[contactfullname] [nvarchar](50) NULL
) ON [PRIMARY]
GO
