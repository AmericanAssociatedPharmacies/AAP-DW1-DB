USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Compliance_All]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [dbo].[usp_Compliance_All]
AS
     SELECT a.PMID
          , e.AccountName
          , ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0) AS [Purchase Qty]
          , ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0) AS [Purchases @ AWP]
          , a.[Dispense Qty]
          , a.[Dispense @ AWP]
          , (ISNULL(b.[Purchase Qty], 0) + ISNULL(c.[Purchase Qty], 0)) - a.[Dispense Qty] AS [Leakage Quantity]
          , (ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0)) - a.[Dispense @ AWP] AS [Leakage @ AWP]
          , CAST((ISNULL(b.[Purchases @ AWP], 0) + ISNULL(c.[Purchases @ AWP], 0)) / a.[Dispense @ AWP] AS DECIMAL(18, 3)) AS TPR
     FROM SSRS.dbo.rpt_Compliance_FDS AS a
          INNER JOIN
     (
         SELECT t1.PMID
         FROM SSRS.dbo.vw_Comp_Days AS t1
     ) AS d ON a.PMID = d.PMID
          INNER JOIN
     (
         SELECT DISTINCT 
                *
         FROM SSRS.DBO.vw_pharmacy
     ) AS e ON a.PMID = e.PMID
          LEFT JOIN SSRS.dbo.rpt_Compliance_API AS b ON a.PMID = b.PMID
          LEFT JOIN SSRS.dbo.rpt_Compliance_CAH AS c ON a.PMID = c.PMID;
GO
