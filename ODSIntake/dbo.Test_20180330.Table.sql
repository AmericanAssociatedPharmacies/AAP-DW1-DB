USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Test_20180330]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_20180330](
	[accountid] [uniqueidentifier] NULL,
	[name] [nvarchar](160) NULL,
	[primarycontactid] [uniqueidentifier] NULL,
	[primarycontactidname] [nvarchar](100) NULL,
	[primarycontactidyominame] [nvarchar](100) NULL,
	[telephone1] [nvarchar](50) NULL
) ON [PRIMARY]
GO
