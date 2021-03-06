USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIPricing_AZ_ETL]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APIPricing_AZ_ETL]

	@RowID INT

AS

SET NOCOUNT ON;

BEGIN

	SELECT RowID AS DW1SourceRowID, NDC, API_ItemNumber, DateKey, APINetPrice, APIManufacturerInvoicePrice, APICustomerInvoicePrice, APIPricePerUnit, APIRebate
	, APIRebatePercentage, APIHoldBackPrice, APICustomerNetPrice
	FROM dbo.APIPricing
	WHERE RowID > @RowID



END
GO
