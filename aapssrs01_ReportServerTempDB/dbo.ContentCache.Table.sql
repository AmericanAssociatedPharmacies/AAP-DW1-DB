USE [aapssrs01_ReportServerTempDB]
GO
/****** Object:  Table [dbo].[ContentCache]    Script Date: 12/22/2020 5:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentCache](
	[ContentCacheID] [bigint] IDENTITY(1,1) NOT NULL,
	[CatalogItemID] [uniqueidentifier] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ParamsHash] [int] NULL,
	[EffectiveParams] [nvarchar](max) NULL,
	[ContentType] [nvarchar](256) NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[Version] [smallint] NULL,
	[Content] [varbinary](max) NULL,
 CONSTRAINT [PK_ContentCache] PRIMARY KEY NONCLUSTERED 
(
	[ContentCacheID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
