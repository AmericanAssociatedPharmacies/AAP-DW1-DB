USE [SalesDDS]
GO
/****** Object:  Table [dbo].[EventDimCAH_AfterUpdate]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventDimCAH_AfterUpdate](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[EventKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EventDimCAH_AfterUpdate] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
