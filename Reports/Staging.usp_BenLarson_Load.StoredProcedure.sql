USE [Reports]
GO
/****** Object:  StoredProcedure [Staging].[usp_BenLarson_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [Staging].[usp_BenLarson_Load]

AS

SET NOCOUNT ON;

BEGIN


	TRUNCATE TABLE Staging.BenLarson;

	INSERT INTO Staging.BenLarson(PMID, WHAccountID, InvNbr, InvDate, APIItemNbr, NDC, PackSize, ItemDescription, Qty, UnitAmount, ExtSales, Type, ItemGrp)
	SELECT p.PMID
	, p.APINumber AS [WHAccountID]
	, e.[InvoiceNumber] AS [InvNbr]
	, e.[InvoiceDate] AS [InvDate]
	, e. [ItemNumber] AS [APIItemNbr]
	, dd.[NDC]
	, d.PS AS PackSize
	, e.[ItemDescription]
	, s.APIInvoiceQuantity AS [Qty]
	, s.APIUnitAmount AS [UnitAmount]
	, s.APIExtendedAmount AS [ExtSales]
	, e.[Type]
	, e.[ItemGroupNumber] AS [ItemGrp]
	FROM SalesDDS.[dbo].[SalesFact_API] AS s
	INNER JOIN SalesDDS.[dbo].[EventDimAPI] AS e
									ON s.[APIEventKey] = e.EventKey
									AND s.[APIEventDateKey] = e.DateKey
	INNER JOIN SalesDDS.dbo.PharmacyDim AS p ON s.PharmacyKey = p.PharmacyKey
	INNER JOIN SalesDDS.dbo.DrugDim AS dd ON s.DrugKey = dd.DrugKey
	LEFT OUTER JOIN Medispan.dbo.DrugMaster AS d ON dd.NDC = d.NDC 
	INNER JOIN(SELECT [WHAccountID]
					, CAST(CONVERT(VARCHAR(20),MAX(InvDate),112) as INT) AS MaxInvDateKey
					FROM [dbo].[BenLarson]
					GROUP BY [WHAccountID]	
					) AS dt ON dt.[WHAccountID] = p.APINumber
								AND s.DateKey >= dt.MaxInvDateKey
	WHERE p.APINumber IN('3423133'
							, '3423200'
							, '3425181'
							, '3255741'
							, '3252076'
							, '3422634'
							, '3428467'
							, '3257455'
							, '3423061'
							, '3424043'
							, '3429345'
							, '3425000'
							, '3424444'
							, '3127541'
							, '3428467'
							, '3423061'
							, '3254262'
							, '3252330'
							, '3422030'
							, '3429118'
							, '3427797'
							)	
	AND e.Type IN ('Generic', 'Brand')	
	AND s.APIUnitAmount > 0
	ORDER BY s.DateKey ASC, p.APINumber ASC
	
END


/* Old SQL code. Was creating a cartesian product. Added the API Account # for the NCPDP # below

	

	--OR EXISTS(SELECT 1
	--			FROM RXMaster.dbo.PharmacyDim AS p
	--			WHERE p.NCPDP = '4908832'
	--			AND a.WHAccountID = p.[APINumber]
	--					)


	--API Account #'s pre-S2k RSE 20200814
	--WHERE e.[AccountNumber] IN('42093133'
	--					, '42123200'
	--					, '42155181'
	--					, '42192634'
	--					, '42208467'
	--					, '42035000'
	--					, '42132644'
	--					, '12137541'
	--					, '42214444'
	--					, '42083061'
	--					, '25074262'
	--					, '42199345'
	--					, '25232330'
	--					, '42192030'
	--					, '25185522' -- Added RSE 01/13/2020
	--					, '25185741' -- Added RSE 01/13/2020
	--					, '25157455' -- Added RSE 01/13/2020
	--					)



*/







GO
