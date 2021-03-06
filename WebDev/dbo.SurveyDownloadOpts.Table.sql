USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyDownloadOpts]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyDownloadOpts](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[jsonOptions] [nvarchar](max) NULL,
	[ParentEntityId] [nvarchar](50) NULL,
	[EntityType] [nvarchar](350) NULL,
	[EntityIdName] [nvarchar](350) NULL,
	[EntityId] [nvarchar](50) NULL,
	[Section] [nvarchar](350) NULL,
	[SurveyId] [int] NULL,
	[QuestionId] [int] NULL,
	[PMId] [int] NULL,
	[IsActive] [bit] NULL,
	[DefaultColumns] [nvarchar](max) NULL,
 CONSTRAINT [PK_SurveyDownloadOpts] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyDownloadOpts] ADD  CONSTRAINT [DF_SurveyDownloadOpts_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
