USE [WebDev]
GO
/****** Object:  View [dbo].[v_web_APISalesMTD2]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[v_web_APISalesMTD2]
AS
/*
API_SalesMTD is updated daily by a job, for example on 2/4/17 start is 2/1, end is 2/3
2/3/17 request to add previous months sales
*/
SELECT     
	a.APIAccountNo as [API Account No]
	--, a.PMID
	,'Month to Date' as 'Month'
	, convert(varchar,a.StartDate,101) as [Start Date]
	, convert(varchar,a.EndDate ,101) as [End Date]
	, a.BrandSales as [Brand Sales]
	, a.GenericSales as [Generic Sales]
	, a.OTCSales as [OTC Sales]
	, a.TotalSales as [Total Sales]
	--,case when v.whapitotal is null then '(not available)' else cast(v.whapitotal as varchar) end as [Previous Month Sales]
	FROM   WebDev..API_SalesMTD a
GO
