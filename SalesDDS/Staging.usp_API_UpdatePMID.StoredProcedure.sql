USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_API_UpdatePMID]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_API_UpdatePMID]

	@DateKey INT

AS

SET NOCOUNT ON;

BEGIN



UPDATE [Staging].[API]
SET PMID = ISNULL(p.PMID, 0)
FROM [Staging].[API] AS x
LEFT OUTER JOIN PharmacyMaster.dbo.PM_Pharmacy AS p ON LEFT(p.APIAccountNo, 8) = LEFT(x.WHAccountID, 8)
WHERE x.DateKey = @DateKey


END

GO
