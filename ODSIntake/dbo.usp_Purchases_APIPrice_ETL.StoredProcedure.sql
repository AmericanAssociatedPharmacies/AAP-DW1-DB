USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Purchases_APIPrice_ETL]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_Purchases_APIPrice_ETL]

AS

SET NOCOUNT ON;

BEGIN

	SELECT APIItemNbr
	, NDC
	, [DESCRIPTION]
	, Unit
	, Size
	, [Contract]
	, APIPrice
	, GPI
	, AdjRebate
	, DateLoaded
	FROM dbo.vwPurchasesAPIPricing

END
GO
