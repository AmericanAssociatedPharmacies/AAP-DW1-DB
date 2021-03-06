USE [WebDev]
GO
/****** Object:  Table [dbo].[ContactMobileInfo]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactMobileInfo](
	[pmid] [int] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[mobilenumber] [nvarchar](50) NULL,
	[cancontactmobile] [int] NULL,
	[periodicfaxes] [int] NULL,
 CONSTRAINT [PK_ContactMobileInfo] PRIMARY KEY CLUSTERED 
(
	[pmid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
