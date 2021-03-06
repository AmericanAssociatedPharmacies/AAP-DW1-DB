USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyQuestion]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyQuestion](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SurveyId] [int] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[Index] [smallint] NULL,
	[IsEnable] [bit] NULL,
	[IsActive] [bit] NOT NULL,
	[IsRequired] [bit] NULL,
	[RequiredValue] [nvarchar](max) NULL,
	[ShowFunction] [nvarchar](max) NULL,
	[ValidateFunction] [nvarchar](200) NULL,
	[ShowSurveyOptionId] [int] NULL,
	[Type] [nvarchar](250) NOT NULL,
	[ChildIds] [nvarchar](550) NULL,
	[ParentId] [int] NULL,
	[IsMultipleAnswers] [bit] NULL,
	[Section] [nvarchar](350) NULL,
	[qHtml] [nvarchar](max) NULL,
	[Source] [nvarchar](max) NULL,
 CONSTRAINT [PK_Questions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyQuestion] ADD  CONSTRAINT [DF_SurveyQuestion_IsActive]  DEFAULT ((1)) FOR [IsEnable]
GO
ALTER TABLE [dbo].[SurveyQuestion] ADD  CONSTRAINT [DF_SurveyQuestion_IsEnable]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[SurveyQuestion] ADD  CONSTRAINT [DF_SurveyQuestion_IsRequired]  DEFAULT ((1)) FOR [IsRequired]
GO
ALTER TABLE [dbo].[SurveyQuestion] ADD  CONSTRAINT [DF_SurveyQuestion_IsMultipleOps]  DEFAULT ((0)) FOR [IsMultipleAnswers]
GO
ALTER TABLE [dbo].[SurveyQuestion]  WITH NOCHECK ADD  CONSTRAINT [FK_SurveyQuestion] FOREIGN KEY([SurveyId])
REFERENCES [dbo].[Survey] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SurveyQuestion] CHECK CONSTRAINT [FK_SurveyQuestion]
GO
