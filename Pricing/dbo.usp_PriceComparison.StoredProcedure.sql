USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_PriceComparison]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/16/2017>
-- Description:	<Price Comparison Report>
-- =============================================
CREATE PROCEDURE [dbo].[usp_PriceComparison]

	-- Add the parameters for the stored procedure here
		@NDC varchar (200)

AS

SET NOCOUNT ON;

BEGIN

	SELECT [GPI]
      ,[API_NDC]
      ,[CAH_NDC]
      ,[ABC_NDC]
      ,[DrugName]
      ,[API_ItemNumber]
      ,[API_PackageSize]
      ,[APICustomerInvoicePrice]
      ,[APICustomerNetPrice]
      ,[API_Manufacturer]
      ,[CardinalInvoicePrice]
      ,[CardinalPackageSize]
      ,[CAH_Manufacturer]
      ,[ABCInvoicePrice]
      ,[ABCPackageSize]
      ,[ABC_Manufacturer]
      ,[RowID]
	FROM [dbo].[PriceCompare_RSE_20170815]
	WHERE API_NDC = @NDC
	 

END


GO
