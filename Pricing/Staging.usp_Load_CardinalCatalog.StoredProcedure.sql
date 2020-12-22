USE [Pricing]
GO
/****** Object:  StoredProcedure [Staging].[usp_Load_CardinalCatalog]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [Staging].[usp_Load_CardinalCatalog]

AS

SET NOCOUNT ON;

BEGIN

SELECT RN, NDC, CardinalItemNumber, CardinalInvoicePrice, Size, DateKey, ContractType
FROM [Staging].[vwCardinalCatalog]
WHERE RN = 1
END
GO
