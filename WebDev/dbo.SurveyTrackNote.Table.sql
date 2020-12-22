USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyTrackNote]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyTrackNote](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TrackChangeId] [int] NULL,
	[PMId] [int] NULL,
	[Notes] [nvarchar](max) NULL,
 CONSTRAINT [PK_SurveyTrackNote] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyTrackNote]  WITH NOCHECK ADD  CONSTRAINT [FK_SurveyTrackNote_SurveyTrackChange] FOREIGN KEY([TrackChangeId])
REFERENCES [dbo].[SurveyTrackChange] ([Id])
GO
ALTER TABLE [dbo].[SurveyTrackNote] CHECK CONSTRAINT [FK_SurveyTrackNote_SurveyTrackChange]
GO
