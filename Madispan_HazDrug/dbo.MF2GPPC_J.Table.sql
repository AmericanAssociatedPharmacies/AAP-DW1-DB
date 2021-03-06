USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[MF2GPPC_J]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2GPPC_J](
	[Generic_Product_Packaging_Code] [varchar](8) NOT NULL,
	[Package_Size] [real] NULL,
	[Package_Size_Unit_of_Measure] [nvarchar](2) NULL,
	[Package_Quantity] [int] NULL,
	[Unit_DoseUnit_of_Use_Package] [nvarchar](1) NULL,
	[Package_Description_Code] [nvarchar](2) NULL,
	[Generic_Product_Identifier] [nvarchar](14) NULL,
	[Reserve] [nvarchar](14) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Generic_Product_Packaging_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
