USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyOption]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyOption](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Text] [nvarchar](max) NULL,
	[Index] [smallint] NULL,
	[Html] [nvarchar](max) NULL,
	[Name] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[IsTrackChange] [bit] NULL,
	[IsReadOnly] [bit] NULL,
	[DefaultValue] [nvarchar](max) NULL,
	[EnableQIds] [nvarchar](50) NULL,
	[DisableQIds] [nvarchar](50) NULL,
	[ScopeName] [nvarchar](250) NULL,
	[opFormat] [nvarchar](50) NULL,
	[MaxLength] [smallint] NULL,
 CONSTRAINT [PK_Options] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyOption] ADD  CONSTRAINT [DF_SurveyOption_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SurveyOption] ADD  CONSTRAINT [DF_SurveyOption_IsTrackChange]  DEFAULT ((0)) FOR [IsTrackChange]
GO
ALTER TABLE [dbo].[SurveyOption] ADD  CONSTRAINT [DF_SurveyOption_IsReadOnly]  DEFAULT ((0)) FOR [IsReadOnly]
GO
ALTER TABLE [dbo].[SurveyOption]  WITH NOCHECK ADD  CONSTRAINT [FK_QuestionOption] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[SurveyQuestion] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SurveyOption] CHECK CONSTRAINT [FK_QuestionOption]
GO
