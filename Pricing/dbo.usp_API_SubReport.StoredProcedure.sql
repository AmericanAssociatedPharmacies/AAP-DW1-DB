USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_SubReport]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/31/2017>
-- Description:	<SubReport for Price Comparison Report Version II>
-- =============================================
CREATE PROCEDURE [dbo].[usp_API_SubReport]

		@GPI varchar(14)
			, @PkSz varchar(200)

AS

SET NOCOUNT ON;

BEGIN

	SELECT DISTINCT
	   [GPI]
      ,[API_NDC]
      ,[DrugName]
      ,[API_ItemNumber]
      ,[API_PackageSize]
      ,[API_Manufacturer]
	  ,[APICustomerInvoicePrice]
      ,[APICustomerNetPrice]
	FROM [dbo].[PriceCompare_RSE_20170815]
	WHERE [GPI] = @GPI 
		AND [API_PackageSize] = @PkSz
	ORDER BY [API_PackageSize] ASC , [APICustomerInvoicePrice] ASC


END
GO
