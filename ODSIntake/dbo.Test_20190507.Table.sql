USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Test_20190507]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test_20190507](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[C1] [varchar](255) NULL,
	[C2] [varchar](255) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Test_20190507] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
