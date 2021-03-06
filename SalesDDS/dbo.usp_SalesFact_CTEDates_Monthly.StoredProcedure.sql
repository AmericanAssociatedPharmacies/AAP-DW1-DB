USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_CTEDates_Monthly]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[usp_SalesFact_CTEDates_Monthly]

AS


SET NOCOUNT ON;

BEGIN

	WITH CTE_DATES
	AS(SELECT CONVERT(DATETIME, '20130101') AS StartDate
		, CONVERT(DATETIME, '20130201') AS EndDate
		
		UNION ALL

		SELECT DATEADD(mm, 1, StartDate) AS StartDate, DATEADD(mm, 1, EndDate) AS EndDate
		FROM CTE_DATES
		WHERE StartDate < '20180101'
	) 
	SELECT StartDate, EndDate
	FROM CTE_DATES
	WHERE StartDate < '20180101'
	OPTION (MAXRECURSION 0)


END


GO
