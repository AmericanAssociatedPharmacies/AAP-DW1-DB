USE [ODSIntake]
GO
/****** Object:  Table [Staging].[RawOrder]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[RawOrder](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RawOrder] [varchar](8000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[RawOrder] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
