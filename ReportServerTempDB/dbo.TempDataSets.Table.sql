USE [ReportServerTempDB]
GO
/****** Object:  Table [dbo].[TempDataSets]    Script Date: 12/22/2020 7:48:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempDataSets](
	[ID] [uniqueidentifier] NOT NULL,
	[ItemID] [uniqueidentifier] NOT NULL,
	[LinkID] [uniqueidentifier] NULL,
	[Name] [nvarchar](260) NOT NULL,
 CONSTRAINT [PK_TempDataSet] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TempDataSets]  WITH NOCHECK ADD  CONSTRAINT [FK_DataSetItemID] FOREIGN KEY([ItemID])
REFERENCES [dbo].[TempCatalog] ([TempCatalogID])
GO
ALTER TABLE [dbo].[TempDataSets] CHECK CONSTRAINT [FK_DataSetItemID]
GO
