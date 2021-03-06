USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyTrackChange]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyTrackChange](
	[Id] [int] NOT NULL,
	[SurveyId] [int] NULL,
	[OptionId] [int] NULL,
 CONSTRAINT [PK_TrackChange] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
