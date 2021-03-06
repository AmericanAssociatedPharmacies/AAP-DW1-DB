USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_StagingSalesFactLoad_GetDateKeys]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_StagingSalesFactLoad_GetDateKeys]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.DateKey
	FROM(SELECT DISTINCT DateKey
			FROM Staging.API

			UNION 

			SELECT DISTINCT DateKey
			FROM Staging.CAH
		) AS dt
	ORDER BY dt.DateKey ASC

END
GO
