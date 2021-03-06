USE [ODSIntake]
GO
/****** Object:  View [dbo].[vwCardinalOTC_File2]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwCardinalOTC_File2]
AS
SELECT LTRIM(RTRIM([NDC])) AS [NDC]
     , LTRIM(RTRIM([Order Qty])) AS [Order Qty]
     , LTRIM(RTRIM([Return Qty])) AS [Return Qty]
     , LTRIM(RTRIM([Ship Qty])) AS [Ship Qty]
     , LTRIM(RTRIM([Dollars])) AS [Dollars]
     , LTRIM(RTRIM([Trade Name])) AS [Trade Name]
     , LTRIM(RTRIM([Generic Name])) AS [Generic Name]
     , LTRIM(RTRIM([CIN])) AS [CIN]
     , LTRIM(RTRIM([Mfr])) AS [Mfr]
     , LTRIM(RTRIM([Strength])) AS [Strength]
     , LTRIM(RTRIM([Form])) AS [Form]
     , LTRIM(RTRIM([Size])) AS [Size]
     , LTRIM(RTRIM([Contract Indicator])) AS [Contract Indicator]
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0'
               ,'Excel 12.0 Xml;Database=C:\Nova_CardinalFiles\80 20 Product Movement ReportDE2-OTC - Display.xlsx;HDR=YES'
               ,'select * FROM [Load$a1:m]'
               )
GO
