USE [ODSIntake]
GO
/****** Object:  Table [Staging].[ServerNameDbName_SSISLoop]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ServerNameDbName_SSISLoop](
	[ServerName] [varchar](100) NULL,
	[DbName] [varchar](100) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[ServerNameDbName_SSISLoop] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
