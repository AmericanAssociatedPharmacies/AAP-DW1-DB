USE [SalesODS]
GO
/****** Object:  Table [dbo].[APISalesDetail_ETL]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APISalesDetail_ETL](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[ActionType] [varchar](25) NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[SourceRowCreatedDate] [datetime] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APISalesDetail_ETL] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
