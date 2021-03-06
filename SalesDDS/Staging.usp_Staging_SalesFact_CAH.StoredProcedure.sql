USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Staging_SalesFact_CAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_Staging_SalesFact_CAH]

	@DateKey INT

AS

SET NOCOUNT ON;


BEGIN

	DELETE s
	FROM Staging.SalesFact_CAH AS s
	INNER JOIN dbo.SalesFact_CAH AS c ON s.[PharmacyKey] = c.PharmacyKey
											AND s.DateKey = c.DateKey
											AND s.DrugKey = c.DrugKey
											AND s.CAHEventKey = c.CAHEventKey
											AND s.CAHEventDateKey = c.CAHEventDateKey
	WHERE s.DateKey = @DateKey



END
GO
