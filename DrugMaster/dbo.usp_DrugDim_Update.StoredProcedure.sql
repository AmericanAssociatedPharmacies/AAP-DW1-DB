USE [DrugMaster]
GO
/****** Object:  StoredProcedure [dbo].[usp_DrugDim_Update]    Script Date: 12/22/2020 6:57:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_DrugDim_Update]

AS

SET NOCOUNT ON;

BEGIN
BEGIN TRY

	--DrugMaster db
	UPDATE x
	SET [IsAPITier1] = s.[Tier1Item]
	, [IsAPITier2] =  s.Tier2Item
	, APIGroupID = s.GroupID
	FROM [dbo].[DrugDim] AS x
	INNER JOIN [Staging].[APICatalog] AS s ON x.NDC = s.NDC



	--Pricing db
	UPDATE x
	SET [IsAPITier1] = s.[Tier1Item]
	, [IsAPITier2] = s.Tier2Item
	, APIGroupID = s.GroupID
	FROM Pricing.[dbo].[DrugDim] AS x
	INNER JOIN [Staging].[APICatalog] AS s ON x.NDC = s.NDC

	--SalesDDS db
	UPDATE x
	SET [IsAPITier1] = s.[Tier1Item]
	, [IsAPITier2] = s.Tier2Item
	, APIGroupID = s.GroupID
	FROM SalesDDS.[dbo].[DrugDim] AS x
	INNER JOIN [Staging].[APICatalog] AS s ON x.NDC = s.NDC

	--ClaimsDDS db
	UPDATE x
	SET [IsAPITier1] = s.[Tier1Item]
	, [IsAPITier2] = s.Tier2Item
	, APIGroupID = s.GroupID
	FROM ClaimsDDS.[dbo].[DrugDim] AS x
	INNER JOIN [Staging].[APICatalog] AS s ON x.NDC = s.NDC

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
