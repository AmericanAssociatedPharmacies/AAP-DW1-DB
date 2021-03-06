USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_CAH_AfterUpdate]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SalesFact_CAH_AfterUpdate]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN

	--Update any PharmacyKey values that were fixed in the Source db
	UPDATE X
	SET [PharmacyKey] = ISNULL(ca.PharmacyKey, x.PharmacyKey)	
	FROM [dbo].[SalesFact_CAH] AS x 
	INNER JOIN dbo.EventDimCAH AS cah ON x.CAHEventKey = cah.EventKey
										AND x.CAHEventDateKey = cah.DateKey
	INNER JOIN(SELECT MAX(RowID) AS MaxRowID
				, EventKey
				, DateKey
				FROM dbo.EventDimCAH_AfterUpdate
				GROUP BY EventKey
				, DateKey
				) AS c ON x.[CAHEventKey] = c.EventKey
						AND x.DateKey = c.DateKey
	CROSS APPLY(SELECT MAX(PharmacyKey) AS PharmacyKey			
						FROM RXMaster.dbo.PharmacyDim AS p
						WHERE EndDateKey <= c.DateKey
						AND StartDateKey >= c.DateKey
						AND p.PMID = cah.PMID						
					) AS ca
	WHERE x.PharmacyKey <> ca.PharmacyKey
	AND x.DateKey = @DateKey

END

GO
