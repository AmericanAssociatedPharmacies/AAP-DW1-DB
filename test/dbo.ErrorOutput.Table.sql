USE [test]
GO
/****** Object:  Table [dbo].[ErrorOutput]    Script Date: 12/22/2020 8:07:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorOutput](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDateTime] [datetime] NULL,
	[FQNFileName] [varchar](1000) NULL,
	[FileErrorRowNumber] [int] NOT NULL,
	[ErrorData] [varchar](8000) NOT NULL,
	[ErrorDescription] [varchar](8000) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorOutput] ADD  CONSTRAINT [df_RowCreatedDate]  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
