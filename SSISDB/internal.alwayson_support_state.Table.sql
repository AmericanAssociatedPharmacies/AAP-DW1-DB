USE [SSISDB]
GO
/****** Object:  Table [internal].[alwayson_support_state]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[alwayson_support_state](
	[server_name] [nvarchar](256) NOT NULL,
	[state] [tinyint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[server_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
