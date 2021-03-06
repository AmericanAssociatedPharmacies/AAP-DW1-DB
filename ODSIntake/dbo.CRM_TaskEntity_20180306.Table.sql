USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CRM_TaskEntity_20180306]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_TaskEntity_20180306](
	[activitytypecode] [nvarchar](250) NULL,
	[actualstart] [date] NULL,
	[category] [nvarchar](250) NULL,
	[createdbyname] [nvarchar](100) NULL,
	[description] [nvarchar](max) NULL,
	[modifiedbyname] [nvarchar](100) NULL,
	[owneridname] [nvarchar](100) NULL,
	[owneridtype] [nvarchar](250) NULL,
	[prioritycodename] [nvarchar](250) NULL,
	[regardingobjectidname] [nvarchar](100) NULL,
	[scheduledstart] [datetime] NULL,
	[statecodename] [nvarchar](250) NULL,
	[statuscodename] [nvarchar](250) NULL,
	[subject] [nvarchar](200) NULL,
	[ownerid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
