USE [Reports]
GO
/****** Object:  Table [Staging].[BenLarson]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[BenLarson](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [nvarchar](100) NULL,
	[WHAccountID] [varchar](32) NULL,
	[InvNbr] [varchar](32) NULL,
	[InvDate] [datetime2](3) NULL,
	[APIItemNbr] [varchar](50) NULL,
	[NDC] [varchar](11) NULL,
	[PackSize] [numeric](8, 3) NULL,
	[ItemDescription] [varchar](125) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitAmount] [decimal](18, 2) NULL,
	[ExtSales] [decimal](18, 2) NULL,
	[FileSource] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[Type] [varchar](15) NULL,
	[ItemGrp] [varchar](5) NULL,
 CONSTRAINT [CPK_Staging_BenLarson] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[BenLarson] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
