USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[software_bak]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[software_bak](
	[ID] [nvarchar](255) NOT NULL,
	[SOFTWARE] [nvarchar](255) NULL,
 CONSTRAINT [PK_software] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
