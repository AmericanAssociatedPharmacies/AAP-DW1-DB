USE [InventoryODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_Inventory_GetMaxRowversionID]    Script Date: 12/22/2020 7:02:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_API_Inventory_GetMaxRowversionID]

AS

SET NOCOUNT ON;

BEGIN

	
	SELECT dt.RowversionID
	FROM(SELECT CONVERT(VARCHAR(1000), MAX(RowversionID), 1) AS RowversionID
			FROM [Archive].[APIInventory]
		) AS dt

END
GO
