USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_Count]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Compliance_Count] 

		@PMID INT

AS

SET NOCOUNT ON;
BEGIN

DECLARE @StartDate DATETIME
, @EndDate DATETIME
, @DaysCount INT


SET @StartDate = DATEADD(day, -91, GETDATE())
SET @EndDate = dateadd(d, datediff(d,0, GETDATE()), 0)

	SELECT dt.DayCount
	FROM(SELECT CONVERT(INT,DATEDIFF(y, MIN(dd.TheDate), MAX(dd.TheDate))) AS DayCount
		FROM ClaimsDDS.dbo.DateDim AS dd
		INNER JOIN ClaimsDDS.dbo.ClaimFactFDS AS cf ON cf.DateOfServiceKey = dd.DateKey
		INNER JOIN ClaimsDDS.dbo.PharmacyDim AS pd ON cf.PharmacyKey = pd.PharmacyKey
		WHERE dd.TheDate BETWEEN @StartDate AND @EndDate
		AND pd.PMID = @PMID
	) AS dt

    END;
GO
