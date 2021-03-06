USE [Medispan]
GO
/****** Object:  View [Staging].[vwM25_A]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Staging].[vwM25_A]

AS


SELECT CONVERT(VARCHAR(11), LTRIM(RTRIM(A.NDC_UPC_HRI))) AS [NDC_UPC_HRI]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.ID_Number_Format_Code))) AS [ID_Number_Format_Code]
, NULL  AS Record_Code --Unable to locate any object or code
, NULL AS Record_Code_ID --Unable to locate any object or code
, CASE 
	WHEN CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Transaction_Code)))  NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
		ELSE CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Transaction_Code)))
		END AS [Transaction_Code]
, NULL AS Sequence_Code --Unable to locate
, NULL AS Labeler_Code --Unable to locate any object or code
, NULL AS Generic_ID_Type_Code --Unable to locate any object or code
, NULL AS Generic_ID_Number --Unable to locate any object or code
, CASE 
	WHEN CONVERT(VARCHAR(5), LTRIM(RTRIM(A.DEA_Class_Code))) NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE CONVERT(VARCHAR(5), LTRIM(RTRIM(A.DEA_Class_Code)))
	END AS [DEA_Class_Code]
, NULL AS AHFSCC_Therapeutic_Class_Code --Unable to locate any object or code
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Item_Status_Flag))) AS [Item_Status_Flag]
, NULL AS Local_Systemic_Flag --Unable to locate any object or code
, CONVERT(VARCHAR(2), LTRIM(RTRIM(A.TEE_Code))) AS [TEE_Code]
, NULL Formatted_ID_Number --Unable to locate any object or code
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.RX_OTC_Indicator_Code))) AS [RX_OTC_Indicator_Code]
, CASE 
	WHEN CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Third_Party_Restriction_Code))) NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Third_Party_Restriction_Code)))
	END AS [Third_Party_Restriction_Code] 
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Maintenance_Drug_Code))) AS [Maintenance_Drug_Code]
, CASE 
	WHEN CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Dispensing_Unit_Code))) NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Dispensing_Unit_Code)))
	END AS [Dispensing_Unit_Code]
, CASE 
	WHEN CONVERT(VARCHAR(1), LTRIM(RTRIM(B.[Unit_DoseUnit_of_Use_Package]))) NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
	ELSE CONVERT(VARCHAR(1), LTRIM(RTRIM(B.[Unit_DoseUnit_of_Use_Package])))
	END AS Unit_Dose_Unit_of_Use_Package
, CONVERT(VARCHAR(2), LTRIM(RTRIM(C.Route_of_Administration))) AS [Route_of_Administration]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Form_Type_Code))) AS [Form_Type_Code]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Dollar_Rank_Code))) AS [Dollar_Rank_Code]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Rx_Rank_Code))) AS [Rx_Rank_Code]
, NULL AS Number_System_Character --Unable to locate any object or code
, NULL AS Secondary_ID_Format_Code --Unable to locate any object or code
, NULL AS Secondary_ID_Number --Unable to locate any object or code
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Multi_Source_Code))) AS [Multi_Source_Code]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Brand_Name_Code))) AS [Brand_Name_Code]
, NULL AS Reimbursement_Indicator --Unable to locate any object or code
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Internal_External_Code))) AS [Internal_External_Code]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(C.Single_Combination_Code))) AS [Single_Combination_Code]
, CONVERT(VARCHAR(1), LTRIM(RTRIM(A.Storage_Condition_Code))) AS [Storage_Condition_Code]
, NULL AS Limited_Stability_Code ---Unable to locate any object or code
, CONVERT(VARCHAR(5), LTRIM(RTRIM(C.Last_Change_Date))) AS [Last_Change_Date]
FROM [Medispan_Staging].[dbo].[MF2NDC_H] AS A
INNER JOIN [Medispan_Staging].dbo.MF2NAME_F AS C ON C.Drug_Descriptor_Identifier = A.Drug_Descriptor_Identifier
INNER JOIN [Medispan_Staging].[dbo].[MF2GPPC_J] AS B ON B.[Generic_Product_Packaging_Code] = A.[Generic_Product_Packaging_Code]

GO
