USE [WebDev]
GO
/****** Object:  Table [dbo].[CA_ReportType]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CA_ReportType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReportType] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_CA_ReportType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
