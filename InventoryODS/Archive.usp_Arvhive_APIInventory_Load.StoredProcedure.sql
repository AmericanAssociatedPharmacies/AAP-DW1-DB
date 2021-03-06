USE [InventoryODS]
GO
/****** Object:  StoredProcedure [Archive].[usp_Arvhive_APIInventory_Load]    Script Date: 12/22/2020 7:02:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Archive].[usp_Arvhive_APIInventory_Load]

AS

SET NOCOUNT ON;

BEGIN


	INSERT INTO [Archive].[APIInventory](LPSROM, LPLZON, LPLCID, LPPRDC, LPBATC, LPFPUT, LPLPUT, LPLOQT, LPPIQT, LPSTTC, LPLIST, LPPIPR, LPPUPR, LPSDAT, LPLOCT, LPRQNC, LPUQNC, LPNCCN, LPSENC, LPORFN, LPORFL
										, LPLCRE, LPQCYN, LPTDCD, LPHLBA, RowversionID, ETLDateKey, ETLDate, ETLTime
										)
	SELECT LPSROM, LPLZON, LPLCID, LPPRDC, LPBATC, LPFPUT, LPLPUT, LPLOQT, LPPIQT, LPSTTC, LPLIST, LPPIPR, LPPUPR, LPSDAT, LPLOCT, LPRQNC, LPUQNC, LPNCCN, LPSENC, LPORFN, LPORFL
		, LPLCRE, LPQCYN, LPTDCD, LPHLBA, RowversionID, ETLDateKey, ETLDate, ETLTime
	FROM [Staging].[APIInventory] AS s
	WHERE NOT EXISTS(SELECT 1
						FROM [Archive].[APIInventory] AS a
						WHERE s.RowversionID = a.RowversionID	
						)


END
GO
