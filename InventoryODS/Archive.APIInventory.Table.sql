USE [InventoryODS]
GO
/****** Object:  Table [Archive].[APIInventory]    Script Date: 12/22/2020 7:02:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[APIInventory](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[LPSROM] [char](3) NOT NULL,
	[LPLZON] [char](2) NOT NULL,
	[LPLCID] [char](8) NOT NULL,
	[LPPRDC] [char](35) NOT NULL,
	[LPBATC] [char](13) NOT NULL,
	[LPFPUT] [numeric](8, 0) NOT NULL,
	[LPLPUT] [numeric](8, 0) NOT NULL,
	[LPLOQT] [numeric](17, 3) NOT NULL,
	[LPPIQT] [numeric](17, 3) NOT NULL,
	[LPSTTC] [char](1) NOT NULL,
	[LPLIST] [numeric](7, 0) NOT NULL,
	[LPPIPR] [numeric](3, 0) NOT NULL,
	[LPPUPR] [numeric](3, 0) NOT NULL,
	[LPSDAT] [numeric](8, 0) NOT NULL,
	[LPLOCT] [char](6) NOT NULL,
	[LPRQNC] [numeric](15, 3) NOT NULL,
	[LPUQNC] [numeric](15, 3) NOT NULL,
	[LPNCCN] [numeric](7, 0) NOT NULL,
	[LPSENC] [char](1) NOT NULL,
	[LPORFN] [numeric](7, 0) NOT NULL,
	[LPORFL] [numeric](5, 0) NOT NULL,
	[LPLCRE] [char](1) NOT NULL,
	[LPQCYN] [char](1) NOT NULL,
	[LPTDCD] [char](1) NOT NULL,
	[LPHLBA] [char](1) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[ETLDateKey] [int] NOT NULL,
	[ETLDate] [date] NULL,
	[ETLTime] [time](7) NULL,
 CONSTRAINT [CPK_Archive_APIInventory] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[ETLDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psInventoryODS]([ETLDateKey])
) ON [psInventoryODS]([ETLDateKey])
GO
ALTER TABLE [Archive].[APIInventory] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
