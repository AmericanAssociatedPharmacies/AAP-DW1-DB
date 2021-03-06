USE [ODSIntake]
GO
/****** Object:  Table [Archive].[FairShare]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[FairShare](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[FileRowID] [int] NOT NULL,
	[CustNum] [varchar](500) NULL,
	[ProdNum] [varchar](500) NULL,
	[ProdDesc] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[Count] [varchar](500) NULL,
	[MinExpDate] [varchar](500) NULL,
	[Price] [varchar](500) NULL,
	[MonthlyQty] [varchar](500) NULL,
	[RequestedQty] [varchar](500) NULL,
	[StartDate] [varchar](500) NULL,
	[EndDate] [varchar](500) NULL,
	[FileDir] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[FairShare] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
