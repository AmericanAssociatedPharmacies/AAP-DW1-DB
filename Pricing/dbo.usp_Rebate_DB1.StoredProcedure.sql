USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_Rebate_DB1]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Rebate_DB1]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @DateKey INT

	SET @DateKey = CAST(CONVERT(varchar(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0),112) as INT)

	SELECT dd.NDC, pf.DateKey, pf.APIRebate
	FROM Pricing.dbo.PriceFact AS pf
	INNER JOIN dbo.DrugDim AS dd ON pf.DrugKey = dd.DrugKey
	WHERE pf.DateKey >= @DateKey
	AND pf.APINetPrice IS NOT NULL

END
GO
