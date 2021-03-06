USE [ClaimsDDS]
GO
/****** Object:  Table [Error].[ErrorOutput]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Error].[ErrorOutput](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ErrorDateTime] [datetime] NULL,
	[FQNFileName] [varchar](1000) NULL,
	[StagingRowID] [int] NULL,
	[FileErrorRowNumber] [int] NOT NULL,
	[ErrorData] [varchar](8000) NULL,
	[ErrorDescription] [varchar](8000) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Error_ErrorOutput] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Error].[ErrorOutput] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
