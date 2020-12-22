USE [WebDev]
GO
/****** Object:  Table [dbo].[data_BINReference]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[data_BINReference](
	[PLAN] [nvarchar](255) NULL,
	[ANSI BIN#] [nvarchar](255) NULL,
	[PCN] [nvarchar](255) NULL,
	[COMMERCIAL] [nvarchar](255) NULL,
	[MEDICARE D] [nvarchar](255) NULL,
	[HELP DESK PHONE] [nvarchar](255) NULL
) ON [PRIMARY]
GO
