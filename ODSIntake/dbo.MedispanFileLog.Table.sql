USE [ODSIntake]
GO
/****** Object:  Table [dbo].[MedispanFileLog]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedispanFileLog](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](1000) NULL,
	[FileSize] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[FileDowloadDateTime] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MedispanFileLog] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
