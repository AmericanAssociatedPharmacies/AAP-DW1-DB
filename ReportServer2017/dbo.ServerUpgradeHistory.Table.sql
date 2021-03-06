USE [ReportServer2017]
GO
/****** Object:  Table [dbo].[ServerUpgradeHistory]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerUpgradeHistory](
	[UpgradeID] [bigint] IDENTITY(1,1) NOT NULL,
	[ServerVersion] [nvarchar](25) NULL,
	[User] [nvarchar](128) NULL,
	[DateTime] [datetime] NULL,
 CONSTRAINT [PK_ServerUpgradeHistory] PRIMARY KEY CLUSTERED 
(
	[UpgradeID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServerUpgradeHistory] ADD  DEFAULT (suser_sname()) FOR [User]
GO
ALTER TABLE [dbo].[ServerUpgradeHistory] ADD  DEFAULT (getdate()) FOR [DateTime]
GO
