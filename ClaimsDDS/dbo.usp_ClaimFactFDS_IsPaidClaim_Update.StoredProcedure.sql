USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_ClaimFactFDS_IsPaidClaim_Update]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ClaimFactFDS_IsPaidClaim_Update]


AS

SET NOCOUNT ON;

BEGIN


DECLARE @DateKey INT

DECLARE C1 CURSOR FOR
SELECT DISTINCT DateKey
FROM dbo.EventDimFDS AS e
INNER JOIN [dbo].[ComplianceReportXref] AS x ON e.EventKey = x.EventKey
ORDER BY DateKey DESC

OPEN C1

FETCH NEXT
FROM C1
INTO @DateKey


WHILE @@FETCH_STATUS = 0
BEGIN

	UPDATE x
	SET IsPaidClaim = 1
	FROM dbo.ClaimFactFDS AS x
	WHERE DateOfServiceKey = @DateKey
	AND EXISTS(SELECT 1
				FROM [dbo].[ComplianceReportXref] AS c
				WHERE x.EventKey = c.EventKey
				)


	FETCH NEXT
	FROM C1
	INTO @DateKey


END

CLOSE C1
DEALLOCATE C1


END
GO
