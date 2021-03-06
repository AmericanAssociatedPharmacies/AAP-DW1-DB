USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DB_DateKey_MaxRowversionID]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DB_DateKey_MaxRowversionID]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.RN
	, dt.DateKey
	, dt.MaxRowversionID
	FROM(SELECT RN
			, DateKey
			, CONVERT(VARCHAR(50),master.dbo.fn_varbintohexstr(MaxRowversionID)) AS MaxRowversionID
			FROM [dbo].[CHPH_AAP_DateKey_RowversionID]
		) AS dt
	ORDER BY dt.DateKey ASC, RN ASC

END 
GO
