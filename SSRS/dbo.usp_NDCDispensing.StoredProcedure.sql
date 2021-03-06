USE [SSRS]
GO
/****** Object:  StoredProcedure [dbo].[usp_NDCDispensing]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Author: David Bohler 
Create Date: 08/27/2019 
Description: Compliance Report V5
*/

CREATE PROCEDURE [dbo].[usp_NDCDispensing]
AS
     SELECT t2.NDc AS NDC
          , t2.Manufacturer
          , t3.BIN
          , t3.PlanName
          , t2.GPI
          , t2.DrugName
          , t2.Description
          , t1.QuantityDispensed
          , dd.TheDate as Date
          , t1.IngredientCostSubmitted
          , t1.IngredientCostPaid
          , t1.ClaimAmountPaid
          , t1.CopayAmountSubmitted
          , t1.CopayAmountPaid
          , t1.AWP
          , t1.UandC
     FROM ClaimsDDS.dbo.ClaimFactFDS AS t1
          INNER JOIN
     (
         SELECT a.DateKey
              , a.TheDate
         FROM ClaimsDDS.dbo.DateDim AS a
         WHERE a.TheDate >= '20190701'
               AND a.TheDate <= '20190801'
     ) AS dd ON t1.DateofServiceKey = dd.DateKey
          INNER JOIN ClaimsDDS.dbo.DrugDim AS t2 ON t1.DrugKey = t2.DrugKey
          INNER JOIN ClaimsDDS.dbo.EventDimFDS AS t3 ON t1.EventKey = t3.EventKey
          INNER JOIN ClaimsDDS.dbo.PharmacyDim AS t4 ON t1.PharmacyKey = t4.PharmacyKey
     WHERE t2.NDC <> 'UNKNOWN'
           AND t2.NDC IN('64980028203', '59762011803');
GO
