USE [SalesODS]
GO
/****** Object:  Table [Staging].[APISalesDetailIDs]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APISalesDetailIDs](
	[ID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APISalesDetailIDs] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
