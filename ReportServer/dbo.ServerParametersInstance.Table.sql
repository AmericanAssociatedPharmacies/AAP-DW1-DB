USE [ReportServer]
GO
/****** Object:  Table [dbo].[ServerParametersInstance]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerParametersInstance](
	[ServerParametersID] [nvarchar](32) NOT NULL,
	[ParentID] [nvarchar](32) NULL,
	[Path] [nvarchar](425) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[Timeout] [int] NOT NULL,
	[Expiration] [datetime] NOT NULL,
	[ParametersValues] [image] NOT NULL,
 CONSTRAINT [PK_ServerParametersInstance] PRIMARY KEY CLUSTERED 
(
	[ServerParametersID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
