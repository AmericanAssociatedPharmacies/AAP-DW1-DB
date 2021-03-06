USE [ReportsTest]
GO
/****** Object:  StoredProcedure [test].[usp_rpt_DynamicsTask]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [test].[usp_rpt_DynamicsTask] @StartDate DATETIME
                                             , @EndDate   DATETIME
                                             , @Creator   VARCHAR(50)
AS
     SELECT t1.DateKey
          , t1.createdbyname
          , t1.description
          , t1.regardingobjectidname
          , t1.statecodename
          , t1.subject
          , t1.actualstart
          , t1.actualend
          , t1.RowCreatedDate
          , DATEDIFF(day, t1.actualstart, t1.actualend) AS TimeToComplete
     FROM [DynamicsODS].dbo.CRM_Task AS t1
     WHERE t1.actualstart >= @StartDate
           AND t1.actualend < DATEADD(DAY, 1, @EndDate)
		 AND t1.createdbyname IN  (@Creator)
     ORDER BY t1.actualend DESC;
     RETURN 0;
GO
