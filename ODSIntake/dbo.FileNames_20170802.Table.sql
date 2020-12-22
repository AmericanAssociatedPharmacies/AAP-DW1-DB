USE [ODSIntake]
GO
/****** Object:  Table [dbo].[FileNames_20170802]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileNames_20170802](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileNames] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileNames_20170802] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
