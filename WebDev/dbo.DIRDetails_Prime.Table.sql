USE [WebDev]
GO
/****** Object:  Table [dbo].[DIRDetails_Prime]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRDetails_Prime](
	[Parent Code] [nvarchar](50) NULL,
	[NCPDP] [nvarchar](50) NULL,
	[RxNbr] [nvarchar](50) NULL,
	[Submit Cost] [nvarchar](50) NULL,
	[Conc Fee] [nvarchar](50) NULL,
	[Fill Date] [nvarchar](50) NULL,
	[NDC 1] [nvarchar](50) NULL,
	[NDC] [nvarchar](50) NULL,
	[Client] [nvarchar](50) NULL
) ON [PRIMARY]
GO
