USE [ReportsTest]
GO
/****** Object:  View [dbo].[vw_Does]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_Does] AS 
SELECT t1.InvDate
     , MONTH(t1.InvDate) AS Mnth
     , YEAR(t1.InvDate) AS Yr
     , t2.Unit
     , t2.PS
     , SUM(t1.Qty) AS Qty
     , CASE
           WHEN t2.Unit = 'ML'
           THEN((SUM(t1.Qty) * t2.PS) / 5)
           ELSE(SUM(t1.Qty) * t2.PS)
       END AS TotalDose
FROM API.dbo.APISalesDetail AS t1
     JOIN Medispan.dbo.DrugMaster AS t2 ON t1.NDC = t2.NDC
WHERE t1.InvDate >= '20170101'
      AND t1.Type = 'Generic'
      --AND MONTH(t1.InvDate) = 2
      --AND YEAR(t1.InvDate) = 2018
GROUP BY t1.InvDate
       , MONTH(t1.InvDate)
       , YEAR(t1.InvDate)
       , t2.Unit
       , t2.PS;
--ORDER BY t1.InvDate
--       , MONTH(t1.InvDate)
--       , YEAR(t1.InvDate)
--       , t2.Unit
--       , t2.PS;

--SELECT *
--FROM Medispan.dbo.DrugMaster AS dm
--WHERE dm.PS = '500'
--AND dm.Unit = 'ML'

--SELECT 
--COUNT(dd.IsAPIShipDate) AS BizDay
--FROM Rx30.dbo.DateDim AS dd
--WHERE dd.IsAPIShipDate = 1
--AND dd.IsWeekDay = 1 
--AND dd.IsAPIHoliday <> 1 
--AND dd.Year = 2018
GO
