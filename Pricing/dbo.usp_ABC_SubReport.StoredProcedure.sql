USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_ABC_SubReport]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/31/2017>
-- Description:	<SubReport for Price Comparison Report Version II>
-- =============================================
CREATE PROCEDURE [dbo].[usp_ABC_SubReport]

		@GPI varchar(14)
			, @PkSz varchar(200)

AS

SET NOCOUNT ON;

BEGIN

	SELECT DISTINCT 
	   [ABC_NDC]
      ,[DrugName]
      ,[ABCInvoicePrice]
      ,[ABCPackageSize]
      ,[ABC_Manufacturer]
      ,[GPI]
	FROM [dbo].[PriceCompare_RSE_20170815]
	WHERE [GPI] = @GPI 
		AND [ABCPackageSize] = @PkSz
	ORDER BY [ABCPackageSize] ASC , [ABCInvoicePrice] ASC


END
GO
