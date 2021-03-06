USE [aapssrs01_ReportServerTempDB]
GO
/****** Object:  Table [dbo].[TempCatalog]    Script Date: 12/22/2020 5:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempCatalog](
	[EditSessionID] [varchar](32) NOT NULL,
	[TempCatalogID] [uniqueidentifier] NOT NULL,
	[ContextPath] [nvarchar](425) NOT NULL,
	[Name] [nvarchar](425) NOT NULL,
	[Content] [varbinary](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Intermediate] [uniqueidentifier] NULL,
	[IntermediateIsPermanent] [bit] NOT NULL,
	[Property] [nvarchar](max) NULL,
	[Parameter] [nvarchar](max) NULL,
	[OwnerID] [uniqueidentifier] NOT NULL,
	[CreationTime] [datetime] NOT NULL,
	[ExpirationTime] [datetime] NOT NULL,
	[DataCacheHash] [varbinary](64) NULL,
 CONSTRAINT [PK_TempCatalog] PRIMARY KEY CLUSTERED 
(
	[EditSessionID] ASC,
	[ContextPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UNIQ_TempCatalogID] UNIQUE NONCLUSTERED 
(
	[TempCatalogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TempCatalog] ADD  DEFAULT ((0)) FOR [IntermediateIsPermanent]
GO
