USE [aapssrs01_ReportServer]
GO
/****** Object:  Table [dbo].[UserContactInfo]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserContactInfo](
	[UserID] [uniqueidentifier] NOT NULL,
	[DefaultEmailAddress] [nvarchar](256) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserContactInfo]  WITH CHECK ADD  CONSTRAINT [FK_UserContactInfo_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserContactInfo] CHECK CONSTRAINT [FK_UserContactInfo_Users]
GO
