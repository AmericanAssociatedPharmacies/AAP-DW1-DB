USE [API]
GO
/****** Object:  Table [dbo].[AreteRecordCountLog]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreteRecordCountLog](
	[InsertedDate] [datetime] NULL,
	[TotalCount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AreteRecordCountLog] ADD  DEFAULT (getdate()) FOR [InsertedDate]
GO
