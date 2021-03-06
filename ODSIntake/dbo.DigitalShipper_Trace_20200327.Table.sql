USE [ODSIntake]
GO
/****** Object:  Table [dbo].[DigitalShipper_Trace_20200327]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DigitalShipper_Trace_20200327](
	[RowNumber] [int] IDENTITY(0,1) NOT NULL,
	[EventClass] [int] NULL,
	[TextData] [ntext] NULL,
	[Duration] [bigint] NULL,
	[SPID] [int] NULL,
	[DatabaseID] [int] NULL,
	[DatabaseName] [nvarchar](128) NULL,
	[ObjectType] [int] NULL,
	[LoginName] [nvarchar](128) NULL,
	[CPU] [int] NULL,
	[ApplicationName] [nvarchar](128) NULL,
	[EndTime] [datetime] NULL,
	[HostName] [nvarchar](128) NULL,
	[LoginSid] [image] NULL,
	[NTUserName] [nvarchar](128) NULL,
	[NTDomainName] [nvarchar](128) NULL,
	[ObjectName] [nvarchar](128) NULL,
	[Reads] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[Writes] [bigint] NULL,
	[BinaryData] [image] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
