USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ErrorSFTP]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorSFTP](
	[C1] [varchar](8000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorSFTP] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
