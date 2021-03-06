USE [ClaimsDDS]
GO
/****** Object:  Table [Error].[ManagedErrorLog]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Error].[ManagedErrorLog](
	[RowID] [int] NOT NULL,
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
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
