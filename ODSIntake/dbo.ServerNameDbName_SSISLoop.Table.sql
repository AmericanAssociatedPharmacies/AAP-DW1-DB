USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ServerNameDbName_SSISLoop]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServerNameDbName_SSISLoop](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](100) NULL,
	[DbName] [varchar](100) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServerNameDbName_SSISLoop] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
