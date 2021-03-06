USE [Medispan]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_M25_A]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_Load_M25_A]

AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO Staging.M25_A(NDC_UPC_HRI, ID_Number_Format_Code, Record_Code, Record_Code_ID, Transaction_Code
	, Sequence_Code, Labeler_Code, Generic_ID_Type_Code, Generic_ID_Number, DEA_Class_Code
	, AHFSCC_Therapeutic_Class_Code, Item_Status_Flag, Local_Systemic_Flag, TEE_Code, Formatted_ID_Number
	, RX_OTC_Indicator_Code, Third_Party_Restriction_Code, Maintenance_Drug_Code, Dispensing_Unit_Code
	, Unit_Dose_Unit_of_Use_Package, Route_of_Administration, Form_Type_Code, Dollar_Rank_Code, Rx_Rank_Code
	, Number_System_Character, Secondary_ID_Format_Code, Secondary_ID_Number, Multi_Source_Code, Brand_Name_Code
	, Reimbursement_Indicator, Internal_External_Code, Single_Combination_Code, Storage_Condition_Code
	, Limited_Stability_Code, Last_Change_Date
	)
	SELECT NDC_UPC_HRI, ID_Number_Format_Code, Record_Code, Record_Code_ID, Transaction_Code
	, Sequence_Code, Labeler_Code, Generic_ID_Type_Code, Generic_ID_Number, DEA_Class_Code
	, AHFSCC_Therapeutic_Class_Code, Item_Status_Flag, Local_Systemic_Flag, TEE_Code, Formatted_ID_Number
	, RX_OTC_Indicator_Code, Third_Party_Restriction_Code, Maintenance_Drug_Code, Dispensing_Unit_Code
	, Unit_Dose_Unit_of_Use_Package, Route_of_Administration, Form_Type_Code, Dollar_Rank_Code, Rx_Rank_Code
	, Number_System_Character, Secondary_ID_Format_Code, Secondary_ID_Number, Multi_Source_Code, Brand_Name_Code
	, Reimbursement_Indicator, Internal_External_Code, Single_Combination_Code, Storage_Condition_Code
	, Limited_Stability_Code, Last_Change_Date
	FROM Staging.vwM25_A


END
GO
