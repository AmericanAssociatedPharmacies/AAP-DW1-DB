USE [WebDev]
GO
/****** Object:  Table [dbo].[FairShareProgram_20180627]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FairShareProgram_20180627](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CustNum] [varchar](100) NOT NULL,
	[ProdNum] [varchar](100) NOT NULL,
	[ProdDesc] [nvarchar](255) NOT NULL,
	[Count] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[MonthlyQty] [int] NOT NULL,
	[RequestedQty] [int] NOT NULL,
	[LastUpdated] [datetime] NULL,
	[NDC] [varchar](15) NULL,
	[BeginDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[ShipWeekOf] [datetime] NOT NULL,
	[ExpirationDate] [datetime] NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
