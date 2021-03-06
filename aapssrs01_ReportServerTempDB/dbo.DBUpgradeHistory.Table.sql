USE [aapssrs01_ReportServerTempDB]
GO
/****** Object:  Table [dbo].[DBUpgradeHistory]    Script Date: 12/22/2020 5:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DBUpgradeHistory](
	[UpgradeID] [bigint] IDENTITY(1,1) NOT NULL,
	[DbVersion] [nvarchar](25) NULL,
	[User] [nvarchar](128) NULL,
	[DateTime] [datetime] NULL,
 CONSTRAINT [PK_DBUpgradeHistory] PRIMARY KEY CLUSTERED 
(
	[UpgradeID] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DBUpgradeHistory] ADD  DEFAULT (suser_sname()) FOR [User]
GO
ALTER TABLE [dbo].[DBUpgradeHistory] ADD  DEFAULT (getdate()) FOR [DateTime]
GO
