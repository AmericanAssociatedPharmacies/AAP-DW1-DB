USE [ODSIntake]
GO
/****** Object:  StoredProcedure [Staging].[usp_FairShare]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [Staging].[usp_FairShare]

AS

SET NOCOUNT ON;

BEGIN

SELECT CustNum, ProdNum, ProdDesc, NDC, [Count], ExpirationDate, Price, MonthlyQty, RequestedQty, BeginDate, EndDate, ShipWeekOf, DateKey
FROM [Staging].[vwFairShareProgram]


END
GO
