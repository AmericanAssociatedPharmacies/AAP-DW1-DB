USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RawWebOrders_20180329]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RawWebOrders_20180329](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Col1] [varchar](8000) NULL,
	[Date] [varchar](25) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RawWebOrders_20180329] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
