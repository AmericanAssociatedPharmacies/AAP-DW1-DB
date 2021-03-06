USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDim_IsSourceDelete_Update]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_EventDim_IsSourceDelete_Update]

AS

SET NOCOUNT ON;

BEGIN

UPDATE x
SET IsSourceDelete = 1
FROM dbo.EventDimAPI AS x
INNER JOIN(SELECT EventKey, DateKey
			FROM dbo.EventDimAPI AS a
			WHERE EXISTS(SELECT 1
						FROM SalesODS.Staging.APISalesDetailIDs AS B
						WHERE A.APISalesDetailID = B.ID
						AND A.DateKey = B.DateKey
						) 
			) AS dt ON x.EventKey = dt.EventKey
						AND x.DateKey = dt.DateKey


END
GO
