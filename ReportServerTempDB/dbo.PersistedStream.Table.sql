USE [ReportServerTempDB]
GO
/****** Object:  Table [dbo].[PersistedStream]    Script Date: 12/22/2020 7:48:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersistedStream](
	[SessionID] [varchar](32) NOT NULL,
	[Index] [int] NOT NULL,
	[Content] [image] NULL,
	[Name] [nvarchar](260) NULL,
	[MimeType] [nvarchar](260) NULL,
	[Extension] [nvarchar](260) NULL,
	[Encoding] [nvarchar](260) NULL,
	[Error] [nvarchar](512) NULL,
	[RefCount] [int] NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
 CONSTRAINT [PK_PersistedStream] PRIMARY KEY CLUSTERED 
(
	[SessionID] ASC,
	[Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
