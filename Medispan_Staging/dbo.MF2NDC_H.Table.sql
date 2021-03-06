USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2NDC_H]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2NDC_H](
	[NDC_UPC_HRI] [varchar](11) NOT NULL,
	[Drug_Descriptor_Identifier] [int] NULL,
	[TEE_Code] [nvarchar](2) NULL,
	[DEA_Class_Code] [nvarchar](1) NULL,
	[DESI_Code] [nvarchar](1) NULL,
	[RX_OTC_Indicator_Code] [nvarchar](1) NULL,
	[Generic_Product_Packaging_Code] [nvarchar](8) NULL,
	[Old_NDC_UPC_HRI] [nvarchar](11) NULL,
	[New_NDC_UPC_HRI] [nvarchar](11) NULL,
	[Repackage_Code] [nvarchar](1) NULL,
	[ID_Number_Format_Code] [nvarchar](1) NULL,
	[Third_Party_Restriction_Code] [nvarchar](1) NULL,
	[Knowledge_Base_Drug_Code] [bigint] NULL,
	[KDC_Flag] [nvarchar](1) NULL,
	[Medi_Span_Labeler_Identifier] [int] NULL,
	[Multi_Source_Code] [nvarchar](1) NULL,
	[Name_Type_Code] [nvarchar](1) NULL,
	[Item_Status_Flag] [nvarchar](1) NULL,
	[Innerpack_Code] [nvarchar](1) NULL,
	[Clinic_Pack_Code] [nvarchar](1) NULL,
	[Reserve_1] [nvarchar](2) NULL,
	[PPG_Indicator_Code] [nvarchar](1) NULL,
	[HFPG_Indicator_Code] [nvarchar](1) NULL,
	[Dispensing_Unit_Code] [nvarchar](1) NULL,
	[Dollar_Rank_Code] [nvarchar](1) NULL,
	[Rx_Rank_Code] [nvarchar](1) NULL,
	[Storage_Condition_Code] [nvarchar](1) NULL,
	[Limited_Distribution_Code] [nvarchar](2) NULL,
	[Old_Effective_Date] [bigint] NULL,
	[New_Effective_Date] [bigint] NULL,
	[Next_Smaller_NDC_Suffix_Number] [nvarchar](2) NULL,
	[Next_Larger_NDC_Suffix_Number] [nvarchar](2) NULL,
	[Reserve_2] [nvarchar](13) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[NDC_UPC_HRI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
