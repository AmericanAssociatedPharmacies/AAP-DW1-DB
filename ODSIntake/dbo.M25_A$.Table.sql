USE [ODSIntake]
GO
/****** Object:  Table [dbo].[M25_A$]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25_A$](
	[NDC_UPC_HRI] [nvarchar](255) NULL,
	[ID_Number_Format_Code] [nvarchar](255) NULL,
	[Record_Code] [nvarchar](255) NULL,
	[Record_Code_ID] [nvarchar](255) NULL,
	[Transaction_Code] [nvarchar](255) NULL,
	[Sequence_Code] [nvarchar](255) NULL,
	[Labeler_Code] [nvarchar](255) NULL,
	[Generic_ID_Type_Code] [nvarchar](255) NULL,
	[Generic_ID_Number] [nvarchar](255) NULL,
	[DEA_Class_Code] [nvarchar](255) NULL,
	[AHFSCC_Therapeutic_Class_Code] [nvarchar](255) NULL,
	[Item_Status_Flag] [nvarchar](255) NULL,
	[Local_Systemic_Flag] [nvarchar](255) NULL,
	[TEE_Code] [nvarchar](255) NULL,
	[Formatted_ID_Number] [nvarchar](255) NULL,
	[RX_OTC_Indicator_Code] [nvarchar](255) NULL,
	[Third_Party_Restriction_Code] [nvarchar](255) NULL,
	[Maintenance_Drug_Code] [nvarchar](255) NULL,
	[Dispensing_Unit_Code] [nvarchar](255) NULL,
	[Unit_Dose_Unit_of_Use_Package] [nvarchar](255) NULL,
	[Route_of_Administration] [nvarchar](255) NULL,
	[Form_Type_Code] [nvarchar](255) NULL,
	[Dollar_Rank_Code] [nvarchar](255) NULL,
	[Rx_Rank_Code] [nvarchar](255) NULL,
	[Number_System_Character] [nvarchar](255) NULL,
	[Secondary_ID_Format_Code] [nvarchar](255) NULL,
	[Secondary_ID_Number] [nvarchar](255) NULL,
	[Multi_Source_Code] [nvarchar](255) NULL,
	[Brand_Name_Code] [nvarchar](255) NULL,
	[Reimbursement_Indicator] [nvarchar](255) NULL,
	[Internal_External_Code] [nvarchar](255) NULL,
	[Single_Combination_Code] [nvarchar](255) NULL,
	[Storage_Condition_Code] [nvarchar](255) NULL,
	[Limited_Stability_Code] [nvarchar](255) NULL,
	[Last_Change_Date] [nvarchar](255) NULL
) ON [PRIMARY]
GO
