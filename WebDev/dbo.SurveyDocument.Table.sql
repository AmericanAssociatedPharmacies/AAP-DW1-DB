USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyDocument]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyDocument](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DocumentName] [nvarchar](150) NULL,
	[Section] [nvarchar](150) NULL,
	[Index] [int] NULL,
	[ColumnName] [nvarchar](250) NULL,
	[QuestionId] [int] NULL,
	[OptionId] [int] NULL,
	[DefaultValue] [nvarchar](max) NULL,
	[Format] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_SurveyDocument] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[SurveyDocument] ADD  CONSTRAINT [DF_SurveyDocument_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
