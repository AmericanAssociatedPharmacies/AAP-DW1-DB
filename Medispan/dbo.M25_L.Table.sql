USE [Medispan]
GO
/****** Object:  Table [dbo].[M25_L]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25_L](
	[NDC_UPC_HRI] [varchar](11) NULL,
	[ID_Number_Format_Code] [varchar](1) NULL,
	[Record_Code] [varchar](1) NULL,
	[Record_Code_ID] [numeric](37, 0) NULL,
	[Transaction_Code] [varchar](1) NULL,
	[Reserve_1] [varchar](23) NULL,
	[Dosage_Form] [varchar](4) NULL,
	[Package_Size] [numeric](8, 3) NULL,
	[Package_Size_Unit_of_Measure] [varchar](2) NULL,
	[Package_Quantity] [numeric](37, 0) NULL,
	[Repackage_Code] [varchar](1) NULL,
	[Total_Package_Quantity] [numeric](12, 3) NULL,
	[DESI_Code] [varchar](1) NULL,
	[Package_Description] [varchar](10) NULL,
	[Reserve_2] [varchar](6) NULL,
	[Next_Smaller_NDC_Suffix_Numbe] [varchar](2) NULL,
	[Next_Larger_NDC_Suffix_Number] [varchar](2) NULL,
	[Innerpack_Code] [varchar](1) NULL,
	[Clinic_Pack_Code] [varchar](1) NULL,
	[Reserve_3] [varchar](1) NULL,
	[Last_Change_Date] [varchar](5) NULL
) ON [PRIMARY]
GO
