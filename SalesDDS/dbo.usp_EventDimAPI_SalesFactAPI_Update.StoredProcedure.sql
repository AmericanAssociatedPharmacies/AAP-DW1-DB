USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimAPI_SalesFactAPI_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_EventDimAPI_SalesFactAPI_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY


	UPDATE x
	SET TerritoryManagerNumber = A.TerritoryManagerNumber
	, AccountNumber = A.AccountNumber
	, CustomerReference = A.CustomerReference
	, PMID = A.PMID
	, WharehouseNumber = A.WarehouseNumber
	, ItemGroupNumber = A.ItemGroupNumber
	, AccountGroupNumber = A.AccountGroupNumber
	, NDCOriginal = A.NDCOriginal
	, NDC = A.NDC
	, ItemNumber = A.ItemNumber
	, RowversionID = A.RowversionID
	, IsCredit = A.IsCredit
	, Type = A.Type
	, IsOrderFee = A.IsOrderFee
	, ItemDescription = A.ItemDescription
	, TransTypeCode = A.TransTypeCode
	, TransTypeCodeDesc = A.TransTypeCodeDesc
	, RowversionIDOnDB1 = A.RowversionID
	FROM dbo.EventDimAPI AS x
	INNER JOIN [Staging].[vwEventDimAPI] AS A ON x.APISalesDetailID = A.APISalesDetailID
									AND x.DateKey = A.DateKey



	UPDATE x
	SET APIInvoiceQuantity = s.[Qty]
	, APIUnitAmount = s.[UnitAmount]
	, APILineItemAmount = s.[LineAmt]
	, APIExtendedAmount = s.[ExtSales]
	, APIHoldBackPercent = s.[APIHoldBackPercent]
	, APIHoldBackAmount = s.[APIHoldBackAmount]
	, RebateAfterAPIHoldbackAmount = s.[RebateAfterAPIHoldbackAmount]
	, AffiliateHoldbackPercent = s.[AffiliateHoldbackPercent]
	, AffiliateHoldbackAmount = s.[AffiliateHoldbackAmount]
	, FinalRebateAmount = s.[FinalRebateAmount]
	FROM [dbo].[SalesFact_API] AS x
	INNER JOIN dbo.EventDimAPI AS A ON x.APIEventKey = A.EventKey
										AND x.APIEventDateKey = A.DateKey
	INNER JOIN [Staging].[API] AS S ON S.APISalesDetailID = A.APISalesDetailID
									AND S.DateKey = A.DateKey


END TRY
BEGIN CATCH

	
	DECLARE @ErrorMessage NVARCHAR(4000)
        , @ErrorNumber INT
        , @ErrorSeverity INT
        , @ErrorState INT
        , @ErrorLine INT
        , @ErrorProcedure NVARCHAR(200)

		SELECT 
        @ErrorNumber = ERROR_NUMBER()
        , @ErrorSeverity = ERROR_SEVERITY()
        , @ErrorState = ERROR_STATE()
        , @ErrorLine = ERROR_LINE()
        , @ErrorProcedure = ISNULL(ERROR_PROCEDURE(), '-')
		, @ErrorMessage = ERROR_MESSAGE();

		RAISERROR 
        (@ErrorMessage 
        , @ErrorSeverity, 1               
        , @ErrorNumber    -- parameter: original error number.
        , @ErrorSeverity  -- parameter: original error severity.
        , @ErrorState     -- parameter: original error state.
        , @ErrorProcedure -- parameter: original error procedure name.
        , @ErrorLine       -- parameter: original error line number.
        );
	
END CATCH
END

GO
