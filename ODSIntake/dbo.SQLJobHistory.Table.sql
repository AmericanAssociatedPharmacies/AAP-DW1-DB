USE [ODSIntake]
GO
/****** Object:  Table [dbo].[SQLJobHistory]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQLJobHistory](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](255) NULL,
	[JobName] [varchar](255) NULL,
	[JobStepName] [varchar](255) NULL,
	[StepID] [tinyint] NULL,
	[RunDateTime] [datetime] NULL,
	[SQLSeverity] [int] NULL,
	[IsError] [bit] NOT NULL,
	[ErrorMessage] [varchar](8000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RunDurationInMinutes] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SQLJobHistory] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
