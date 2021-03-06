USE [Pricing]
GO
/****** Object:  StoredProcedure [dbo].[usp_CardinalsalesYTDAWPreport]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_CardinalsalesYTDAWPreport]

AS 

SET NOCOUNT ON;

BEGIN

	--Ouput to produce Excel file
	SELECT CIN, [Generic Name], [Trade Name], a.NDC, a.Strength, a.Form, Size, Mfr, [Month-Year]
	, b.AWPPkg AS AWP, CONVERT(MONEY, (b.PS * b.CSP) * (ISNULL(a.[NADACPricePerUnit], 0.00))) AS NADACUnitPrice
	, a.[Unit Price] , [Ship Qty], [Purchase Dollars]
	--, CONVERT(MONEY, (b.PS * b.CSP) * (ISNULL(a.[NADACPricePerUnit], 0.00))) AS NADACUnitPrice
	FROM [dbo].[CardinalsalesYTDAWPreport] AS A
	LEFT OUTER JOIN Medispan.dbo.DrugMaster AS B ON A.NDC = B.NDC

END
GO
