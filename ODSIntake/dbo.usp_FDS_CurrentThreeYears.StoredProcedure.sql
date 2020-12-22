USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_FDS_CurrentThreeYears]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_FDS_CurrentThreeYears]

AS

SET NOCOUNT ON;

BEGIN

	
	SELECT dt.VarDate
	FROM(SELECT CONVERT(INT,20190101) AS VarDate
			--CAST(CONVERT(VARCHAR(20),DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) - 2, 0),112) as INT) AS VarDate
		) AS dt


END
GO
