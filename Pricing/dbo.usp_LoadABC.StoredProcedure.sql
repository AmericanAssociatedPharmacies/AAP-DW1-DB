USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_LoadABC]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_LoadABC]

AS

SET NOCOUNT ON;

BEGIN


	INSERT INTO [dbo].[ABC](DateKey, ABCItemNum, NDC, ABC_AWP, LPR_Price)
	SELECT DateKey, ABCItemNum, NDC, ABC_AWP, LPR_Price
	FROM Staging.ABC AS A
	WHERE NOT EXISTS(SELECT 1
						FROM [dbo].[ABC] AS a2
						WHERE A.DateKey = a2.DateKey
					)

END
GO
