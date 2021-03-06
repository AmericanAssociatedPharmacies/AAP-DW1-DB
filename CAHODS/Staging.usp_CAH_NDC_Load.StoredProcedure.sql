USE [CAHODS]
GO
/****** Object:  StoredProcedure [Staging].[usp_CAH_NDC_Load]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_CAH_NDC_Load]

AS


SET NOCOUNT ON;

BEGIN

	INSERT INTO [Staging].[CAH_NDC](NDC, ITEM_TYPE, Type, BRAND, MaxDateKey)
	SELECT DISTINCT c.NDC, c.ITEM_TYPE, c.Type, c.BRAND, c.DateKey
	FROM Purchases.dbo.CHPH_AAP AS c
	INNER JOIN(SELECT NDC
				, MAX(DateKey) AS MaxDateKey
				FROM Purchases.dbo.CHPH_AAP
				WHERE DateKey >= 20180101
				GROUP BY NDC
				) AS dt ON  c.DateKey = dt.MaxDateKey
							AND c.NDC = dt.NDC


END
GO
