USE [API]
GO
/****** Object:  StoredProcedure [Staging].[usp_BenLarson_Load]    Script Date: 12/22/2020 6:09:18 AM ******/
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
	SELECT c.PMID, a.[WHAccountID], a.[InvNbr], a.[InvDate], a.[APIItemNbr], a.[NDC], d.PS AS PackSize, [ItemDescription], a.[Qty], a.[UnitAmount], a.[ExtSales], a.[Type], a.[ItemGrp]
	FROM API.dbo.APISalesDetail AS A
	LEFT OUTER JOIN DynamicsODS.[dbo].[vw_CRM_AccountEntity_API] AS U ON A.WHAccountID = u.[APIAccount]
	LEFT OUTER JOIN DynamicsODS.[dbo].[vw_CRM_AccountEntity_User] AS c ON c.[accountid] = u.[accountid]
	LEFT OUTER JOIN Medispan.dbo.DrugMaster AS d ON a.NDC = d.NDC 
	INNER JOIN(SELECT [WHAccountID]
					, MAX(InvDate) AS MaxInvDate
					FROM [dbo].[BenLarson]
					GROUP BY [WHAccountID]	
					) AS dt ON dt.[WHAccountID] = a.[WHAccountID]
								AND a.InvDate >= dt.MaxInvDate 
	WHERE A.WHAccountID IN('42093133'
						, '42123200'
						, '42155181'
						, '42192634'
						, '42208467'
						, '42035000'
						, '42132644'
						, '12137541'
						, '42214444'
						, '42083061'
						, '25074262'
						, '42199345'
						, '25232330'
						, '42192030'
						, '25185522' -- Added RSE 01/13/2020
						, '25185741' -- Added RSE 01/13/2020
						, '25157455' -- Added RSE 01/13/2020
						)
		AND Type IN ('Generic', 'Brand')	
	ORDER BY A.InvDate ASC, a.[WHAccountID] ASC
	
END


/* Old SQL code. Was creating a cartesian product. Added the API Account # for the NCPDP # below

	

	--OR EXISTS(SELECT 1
	--			FROM RXMaster.dbo.PharmacyDim AS p
	--			WHERE p.NCPDP = '4908832'
	--			AND a.WHAccountID = p.[APINumber]
	--					)



*/


GO
