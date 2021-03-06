USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyFlag]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyFlag](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NULL,
	[FlagName] [nvarchar](50) NULL,
	[OptionIds] [nvarchar](500) NULL,
	[OptionValues] [nvarchar](max) NULL,
	[Emails] [nvarchar](500) NULL,
	[EmailSubject] [nvarchar](350) NULL,
	[EmailContent] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[EntityIds] [nvarchar](max) NULL,
 CONSTRAINT [PK_SurveyFlag] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyFlag]  WITH NOCHECK ADD  CONSTRAINT [FK_SurveyFlag_Surveys] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Survey] ([Id])
GO
ALTER TABLE [dbo].[SurveyFlag] CHECK CONSTRAINT [FK_SurveyFlag_Surveys]
GO
