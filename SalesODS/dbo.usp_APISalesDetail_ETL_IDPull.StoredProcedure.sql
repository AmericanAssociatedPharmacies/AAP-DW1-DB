USE [SalesODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail_ETL_IDPull]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_APISalesDetail_ETL_IDPull]


AS


SET NOCOUNT ON;

BEGIN

	SELECT dt.ID
	FROM(SELECT MAX(ID) AS ID
			FROM API.[dbo].[APISalesDetail]
			) AS dt	


END




GO
