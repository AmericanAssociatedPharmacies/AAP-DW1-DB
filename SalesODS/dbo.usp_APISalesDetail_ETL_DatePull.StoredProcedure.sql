USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail_ETL_DatePull]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[usp_APISalesDetail_ETL_DatePull]


AS


SET NOCOUNT ON;

BEGIN

	SELECT dt.InvDate
	FROM(SELECT NULL AS InvDate
			--MAX(InvDate) AS StartDate
			--, DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE())) AS EndDate
			FROM API.[dbo].[APISalesDetail]
			) AS dt
	--CROSS APPLY(SELECT TheDate
	--				FROM Pricing.dbo.DateDim AS dd
	--				WHERE dd.TheDate > dt.StartDate
	--				AND dd.TheDate < dt.EndDate
	--			) AS ca


END



GO
