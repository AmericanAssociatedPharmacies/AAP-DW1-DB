USE [ODSIntake]
GO
/****** Object:  Table [dbo].[DrivesOutput]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrivesOutput](
	[C1] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DrivesOutput] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
