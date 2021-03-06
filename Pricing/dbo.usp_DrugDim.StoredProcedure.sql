USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_DrugDim]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<David Bohler>
-- Create date: <09/14/2017>
-- Report: Price Comparison Report
-- Sub-Report:TBD
-- =============================================
CREATE PROCEDURE [dbo].[usp_DrugDim]

	-- Add the parameters for the stored procedure here
		@GPI varchar (200) = Null
AS

SET NOCOUNT ON;

BEGIN

SELECT DISTINCT 
	   [GPI]
      ,[DrugName]
      ,[PackageSize]
FROM dbo.DrugDim
WHERE [GPI] = @GPI 
ORDER By [DrugName] ASC
END
GO
