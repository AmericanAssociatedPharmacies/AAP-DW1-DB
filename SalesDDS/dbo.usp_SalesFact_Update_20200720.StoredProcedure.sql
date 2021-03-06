USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_Update_20200720]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SalesFact_Update_20200720]

	@DateKey INT

AS

SET NOCOUNT ON

BEGIN

	UPDATE x
	SET [PricePerUnit] = CONVERT(DECIMAL(18,2),(x.[APIExtendedAmount]/x.APIInvoiceQuantity)/(dd.PackageSize * dd.PackageQuantity)) 
	FROM SalesDDS.dbo.SalesFact_API AS x
	INNER JOIN SalesDDS.dbo.DrugDim AS dd ON x.DrugKey = dd.DrugKey	
	WHERE x.DateKey = @DateKey
	AND dd.DrugKey > 0
	AND dd.PackageQuantity IS NOT NULL


	UPDATE s
	SET IsCredit = e.IsCredit
	FROM SalesDDS.dbo.SalesFact_API AS s
	INNER JOIN dbo.EventDimAPI AS e ON s.[APIEventKey] = e.EventKey
										AND s.[APIEventDateKey] = e.DateKey
	WHERE s.DateKey = @DateKey



END
GO
