USE [ReportServer2017TempDB]
GO
/****** Object:  Table [dbo].[SessionLock]    Script Date: 12/22/2020 7:45:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionLock](
	[SessionID] [varchar](32) NOT NULL,
	[LockVersion] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SessionLock] ADD  DEFAULT ((0)) FOR [LockVersion]
GO
