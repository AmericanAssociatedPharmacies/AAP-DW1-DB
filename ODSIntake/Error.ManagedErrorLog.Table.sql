USE [ODSIntake]
GO
/****** Object:  Table [Error].[ManagedErrorLog]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Error].[ManagedErrorLog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Process] [varchar](1000) NOT NULL,
	[Message] [varchar](8000) NULL,
	[StackTrace] [varchar](1000) NULL,
	[Source] [varchar](1000) NULL,
	[Procedure] [varchar](1000) NULL,
	[LineNumber] [int] NULL,
	[InnerException] [varchar](8000) NULL,
	[Number] [int] NULL,
	[State] [int] NULL,
	[TargetSite] [varchar](1000) NULL,
	[HelpLink] [varchar](8000) NULL,
	[SQLErrorCode] [int] NULL,
	[SQLSeverity] [int] NULL,
	[Data] [varchar](8000) NULL,
	[Server] [varchar](1000) NULL,
	[ExceptionType] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Error_ManagedErrorLog] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Error].[ManagedErrorLog] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
