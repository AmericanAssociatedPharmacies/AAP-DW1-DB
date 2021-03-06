USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spGMReport_StoreAvg]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[spGMReport_StoreAvg]
( @ncpdp varchar(11))
as
select top 1 
GMPercent,ClaimCount,LoadDate
,DATENAME(MM, LoadDate) + ' ' + CAST(YEAR(LoadDate) AS VARCHAR(4)) AS [DateRange] 
,(Select top 1 AAPAvg FROM GMAvg order by [date] desc) as AAPAvg 
 from GMStoresAvg where ncpdp=@ncpdp order by [loaddate] desc
GO
