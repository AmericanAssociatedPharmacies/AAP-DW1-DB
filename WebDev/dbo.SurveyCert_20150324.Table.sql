USE [WebDev]
GO
/****** Object:  Table [dbo].[SurveyCert_20150324]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SurveyCert_20150324](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CertName] [nvarchar](150) NULL,
	[Desc] [nvarchar](500) NULL,
	[Type] [nvarchar](50) NULL
) ON [PRIMARY]
GO
