USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ComplianceXref_PMIDs]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ComplianceXref_PMIDs]

AS


SET NOCOUNT ON;

BEGIN

	DECLARE @StartDateKey INT
	, @EndDateKey INT

	SELECT @StartDateKey = CAST(CONVERT(VARCHAR(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) -1, 0),112) AS INT)
	, @EndDateKey = CAST(CONVERT(VARCHAR(20),GETDATE(),112) AS INT)
	FROM dbo.DateDim

	SELECT DISTINCT PMID
	FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
	INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
	WHERE DateofServiceKey BETWEEN @StartDateKey AND @EndDateKey
	AND PMID > 0
	ORDER BY PMID ASC


END
GO
