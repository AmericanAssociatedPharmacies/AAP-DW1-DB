USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_SubReport_Min]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/31/2017>
-- Description:	<SubReport for Price Comparison Report Version II>
-- =============================================
CREATE PROCEDURE [dbo].[usp_CAH_SubReport_Min]

		@GPI varchar(14)
			, @PkSz varchar(200)

AS

SET NOCOUNT ON;

BEGIN

	SELECT DISTINCT 
       MIN ([CardinalInvoicePrice]) AS MinInvoicePrice
      ,[CardinalPackageSize]
      ,[GPI]
	FROM [dbo].[PriceCompare_RSE_20170815]
	WHERE [GPI] = @GPI 
		AND [CardinalPackageSize] = @PkSz
	GROUP BY [CardinalPackageSize], [GPI]
	ORDER BY [CardinalPackageSize] ASC , MinInvoicePrice ASC

END
GO
