USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2PRC_M]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2PRC_M](
	[NDC_UPC_HRI] [varchar](11) NOT NULL,
	[Price_Code] [varchar](1) NOT NULL,
	[Effective_Date] [numeric](19, 0) NOT NULL,
	[Unit_Price] [real] NULL,
	[Unit_Price___Extended] [real] NULL,
	[Package_Price] [real] NULL,
	[AWP_Indicator_Code] [nvarchar](1) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[NDC_UPC_HRI] ASC,
	[Price_Code] ASC,
	[Effective_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
