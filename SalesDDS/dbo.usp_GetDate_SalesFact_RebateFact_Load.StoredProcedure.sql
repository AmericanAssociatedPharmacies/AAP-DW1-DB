USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetDate_SalesFact_RebateFact_Load]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_GetDate_SalesFact_RebateFact_Load]

AS

SET NOCOUNT ON;

BEGIN

	SELECT RN, DateKey
	FROM Staging.API_DatesToLoad
	ORDER BY DateKey ASC

END
GO
