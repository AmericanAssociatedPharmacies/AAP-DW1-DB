USE [WebDev]
GO
/****** Object:  Table [dbo].[surveyanswer_prodbackup8816]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[surveyanswer_prodbackup8816](
	[Id] [int] NOT NULL,
	[PMId] [int] NULL,
	[OptionId] [int] NOT NULL,
	[ParticipatorId] [int] NULL,
	[DateTimeEnter] [datetime] NULL,
	[AnswerInput] [nvarchar](500) NULL,
	[ParticipatorLogin] [nvarchar](50) NULL,
	[IsSubmitted] [bit] NULL,
	[CollectionId] [int] NULL,
	[AnswerText] [nvarchar](500) NULL
) ON [PRIMARY]
GO
