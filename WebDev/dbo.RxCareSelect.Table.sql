USE [WebDev]
GO
/****** Object:  Table [dbo].[RxCareSelect]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RxCareSelect](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date_registered] [datetime] NULL,
	[Firstname] [varchar](50) NULL,
	[Initial] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[Gender] [char](10) NULL,
	[Address1] [varchar](255) NULL,
	[Address2] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](20) NULL,
	[Email] [varchar](255) NULL,
	[Pharmacy] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RxCareSelect] ADD  CONSTRAINT [DF_RxCareSelect_date_registered]  DEFAULT (getdate()) FOR [date_registered]
GO
