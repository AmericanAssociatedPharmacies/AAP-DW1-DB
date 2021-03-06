USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_CHAccounts_Secondary]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_CHAccounts_Secondary](
	[PMID] [nvarchar](255) NULL,
	[DEA] [nvarchar](255) NULL,
	[Second Division] [nvarchar](255) NULL,
	[2nd Primary Number] [nvarchar](255) NULL,
	[2nd 2nd] [nvarchar](255) NULL,
	[2nd 3rd] [nvarchar](255) NULL,
	[2nd POS] [nvarchar](255) NULL,
	[2nd CSOS] [nvarchar](255) NULL,
	[2nd CST] [nvarchar](255) NULL,
	[Third Division] [nvarchar](255) NULL,
	[3rd Primary Number] [nvarchar](255) NULL,
	[3rd 2nd] [nvarchar](255) NULL,
	[3rd POS] [nvarchar](255) NULL,
	[3rd CSOS] [nvarchar](255) NULL,
	[3rd CST] [nvarchar](255) NULL
) ON [PRIMARY]
GO
