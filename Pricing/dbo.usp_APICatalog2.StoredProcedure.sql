USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_APICatalog2]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<David Bohler>
-- Create date: <08/31/2017>
-- Description:	<API Catalog II>
-- =============================================
CREATE PROCEDURE [dbo].[usp_APICatalog2]

	-- Add the parameters for the stored procedure here
		--@DrugName varchar (200) = Null
		@GPI varchar (14) = Null

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
	--WHERE DrugName LIKE ISNULL (CONCAT('%' ,@DrugName, '%'), DrugName)
	WHERE [GPI] = ISNULL (@GPI, GPI)
	ORDER BY [API_PackageSize] ASC;
END
GO
