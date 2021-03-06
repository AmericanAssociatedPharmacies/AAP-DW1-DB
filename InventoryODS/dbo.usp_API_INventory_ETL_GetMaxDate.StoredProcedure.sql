USE [InventoryODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_INventory_ETL_GetMaxDate]    Script Date: 12/22/2020 7:02:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_API_INventory_ETL_GetMaxDate]

AS

SET NOCOUNT ON;

BEGIN

	
	SELECT dt.MaxDate
	FROM(SELECT ISNULL(MAX(CONVERT(DATETIME, CONVERT(VARCHAR, [ETLDateKey], 120))), '19000101') AS MaxDate
			FROM [dbo].[API_Inventory]
		) AS dt

END
GO
