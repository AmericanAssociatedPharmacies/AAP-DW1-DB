USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_GetDates_SalesFactLoad]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_GetDates_SalesFactLoad]

AS 

SET NOCOUNT ON;

BEGIN


	SELECT dt.DateKey
	FROM(SELECT ISNULL(API.DateKey, CAH.DateKey) AS DateKey
		 FROM(SELECT DISTINCT DateKey 
				FROM [Staging].[API]
				) AS API
		FULL OUTER JOIN(SELECT DISTINCT DateKey 
						FROM [Staging].[CAH]
						) AS CAH ON API.DateKey = CAH.DateKey
									
	) AS dt

END

GO
