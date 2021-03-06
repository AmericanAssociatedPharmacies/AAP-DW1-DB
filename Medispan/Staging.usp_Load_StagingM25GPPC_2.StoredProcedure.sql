USE [Medispan]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_StagingM25GPPC_2]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_Load_StagingM25GPPC_2]


AS

SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[M25GPPC_2](Generic_Product_Packaging_Cod, Package_Size, Package_Size_Unit_of_Measure, Package_Quantity, Unit_Dose_Unit_of_Use_Package
										, Package_Description_Code, Generic_Product_Identifier, Transaction_Code, Last_Change_Date, Reserve
										)
	SELECT Generic_Product_Packaging_Cod, Package_Size, Package_Size_Unit_of_Measure, Package_Quantity, Unit_Dose_Unit_of_Use_Package
	, Package_Description_Code, Generic_Product_Identifier, Transaction_Code, Last_Change_Date, Reserve
	FROM Staging.vwM25GPPC_2

END
GO
