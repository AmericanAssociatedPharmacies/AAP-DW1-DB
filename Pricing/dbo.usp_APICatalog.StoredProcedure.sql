USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_APICatalog]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/31/2017>
-- Description:	<API Catalog>
-- Updates
-- 1. <09/20/2017>: Added to additional parameters to increase search functionality.
-- =============================================
CREATE PROCEDURE [dbo].[usp_APICatalog]

	-- Add the parameters for the stored procedure here
		@DrugName varchar (200) = Null
		, @API_ItemNumber varchar (200) = Null
			, @NDC  varchar (15) = Null 


AS

SET NOCOUNT ON;

BEGIN

	SELECT DISTINCT[GPI]
      ,[API_NDC]
      ,[DrugName]
      ,[API_ItemNumber]
      ,[API_PackageSize]
      ,[API_Manufacturer]
	FROM[dbo].[PriceCompare_RSE_20170815]
	WHERE DrugName LIKE ISNULL (CONCAT('%' ,@DrugName, '%'), DrugName)
		AND [API_ItemNumber] = ISNULL (@API_ItemNumber, [API_ItemNumber])
		AND [API_NDC] = ISNUll (@NDC, [API_NDC])
	ORDER BY [DrugName]	 
END
GO
