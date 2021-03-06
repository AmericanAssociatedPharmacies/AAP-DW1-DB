USE [aapssrs01_ReportServer]
GO
/****** Object:  Table [dbo].[DataModelDataSource]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataModelDataSource](
	[DSID] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemId] [uniqueidentifier] NOT NULL,
	[DSType] [int] NOT NULL,
	[DSKind] [int] NOT NULL,
	[AuthType] [int] NOT NULL,
	[ConnectionString] [varbinary](max) NULL,
	[Username] [varbinary](max) NULL,
	[Password] [varbinary](max) NULL,
 CONSTRAINT [PK_DataModelDataSource] PRIMARY KEY CLUSTERED 
(
	[DSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DataModelDataSource]  WITH NOCHECK ADD  CONSTRAINT [FK_DataModelDataSource_Catalog] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Catalog] ([ItemID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DataModelDataSource] CHECK CONSTRAINT [FK_DataModelDataSource_Catalog]
GO
