USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2GPR_L]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2GPR_L](
	[Generic_Product_Packaging_Code] [varchar](8) NOT NULL,
	[GPPC_Price_Code] [varchar](1) NOT NULL,
	[Effective_Date] [numeric](19, 0) NOT NULL,
	[Unit_Price] [real] NULL,
	[Reserve] [nvarchar](27) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Generic_Product_Packaging_Code] ASC,
	[GPPC_Price_Code] ASC,
	[Effective_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
