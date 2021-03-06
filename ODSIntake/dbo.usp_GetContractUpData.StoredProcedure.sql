USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_GetContractUpData]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_GetContractUpData]

AS

SET NOCOUNT ON

BEGIN


SELECT CAST(CONVERT(varchar(20), GETDATE(),112) as INT) AS DateKey
, [case pk]
, [inner pk]
, [1]
, [2]
, [Control Rx]
, [API ITEM #]
, [REPLACE#]
, [NDC #]
, [temp-ndc number]
, [BRAND REFER]
, [ITEM DESCRIPTION]
, [UNIT]
, [SIZE]
, [CONTRACT]
, [INVOICE PRICE]
, [CONTRACT PRICE]
, [API PRICE]
, [FEE SCHED]
, [AWP]
, [PROGRAM]
, [RATE]
, [MFG Multiple for  Rebate]
, [NET PRICE]
, [REBATE]
, [% REBATE]
, [Value Add Factor]
, [Value Add Basis]
, [ADR Item]
, [ADR Expiry]
, [MFG DATE]
, [Work Date]
, [API DATE]
, [REVIEW]
, [GPI]
, [TempSIZE]
, [billable size]
, [billable cost]
, [4% of price]
, [rebate minus 4% of price]
, [Comments]
  FROM [APICONTRACTS]...[CONTRACT-UP] WITH(NOLOCK)

END



GO
