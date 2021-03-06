USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_NDC]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_CAH_NDC]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN


	UPDATE [Staging].[CAH]
	SET [IsBackupSource] = f.[IsBackupSource]
	, [IsTenSource] = f.[IsTenSource]
	, [IsSourceWeekly] = f.[IsSourceWeekly]
	, [IsTopGenerics] = f.[IsTopGenerics]
	FROM [Staging].[CAH] AS x
	INNER JOIN CAHODS.dbo.CAH_FormularyFile AS f ON x.NDC = f.CorrectedNDCUPC
	WHERE x.DateKey = @DateKey

END
										
GO
