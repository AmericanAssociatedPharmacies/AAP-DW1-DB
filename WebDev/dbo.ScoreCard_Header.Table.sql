USE [WebDev]
GO
/****** Object:  Table [dbo].[ScoreCard_Header]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScoreCard_Header](
	[Id] [smallint] NOT NULL,
	[GroupDisplaySeq] [smallint] NOT NULL,
	[GroupTitle] [varchar](500) NULL,
	[SubGroupDisplaySeq] [smallint] NOT NULL,
	[SubGroupTitle] [varchar](500) NOT NULL,
	[DataColumn] [varchar](500) NULL,
	[Client] [varchar](500) NOT NULL,
	[IsActive] [tinyint] NOT NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[ModifiedBy] [varchar](100) NULL,
	[ModifiedOn] [datetime] NULL,
 CONSTRAINT [PK_ScoreCard_Header] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ScoreCard_Header] ADD  CONSTRAINT [DF_ScoreCard_Header_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ScoreCard_Header] ADD  CONSTRAINT [DF_ScoreCard_Header_CreatedBy]  DEFAULT (suser_sname()) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ScoreCard_Header] ADD  CONSTRAINT [DF_ScoreCard_Header_CreatedOn]  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[ScoreCard_Header] ADD  CONSTRAINT [DF_ScoreCard_Header_ModifiedBy]  DEFAULT (suser_sname()) FOR [ModifiedBy]
GO
ALTER TABLE [dbo].[ScoreCard_Header] ADD  CONSTRAINT [DF_ScoreCard_Header_ModifiedOn]  DEFAULT (getdate()) FOR [ModifiedOn]
GO
