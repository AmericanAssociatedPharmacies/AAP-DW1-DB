USE [API]
GO
/****** Object:  Table [dbo].[APISalesDetail_BigC_20170401_20170630]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APISalesDetail_BigC_20170401_20170630](
	[ID] [int] NOT NULL,
	[WHAccountID] [varchar](32) NULL,
	[InvNbr] [varchar](32) NULL,
	[InvLine] [varchar](32) NULL,
	[CustomerName] [varchar](75) NULL,
	[APIItemNbr] [varchar](50) NULL,
	[ItemDescription] [varchar](125) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitAmount] [decimal](18, 2) NULL,
	[ItemGrp] [varchar](5) NULL,
	[AcctGrp] [varchar](5) NULL,
	[Territory] [varchar](4) NULL,
	[InvDate] [datetime2](3) NULL,
	[LineAmt] [decimal](18, 2) NULL,
	[ExtSales] [decimal](18, 2) NULL,
	[OrderNbr] [varchar](15) NULL,
	[NDC_orig] [varchar](50) NULL,
	[NDC] [varchar](11) NULL,
	[DateLoaded] [datetime2](3) NULL,
	[Type] [varchar](15) NULL,
	[WHNbr] [varchar](2) NULL,
	[Rebate] [decimal](18, 2) NULL,
 CONSTRAINT [CPK_APISalesDetail_2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
