USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_BenLarson]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_BenLarson]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @StartInvDate DATETIME
	, @EndInvDate DATETIME
	
	SET @StartInvDate = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()), 0) 
	SET @EndInvDate = DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, 0)

	SELECT c.PMID, [WHAccountID], [InvNbr], [InvDate], [APIItemNbr], a.[NDC], d.PS AS PackSize, [ItemDescription], [Qty], [UnitAmount], [ExtSales]
	FROM API.dbo.APISalesDetail AS A
	LEFT OUTER JOIN DynamicsODS.[dbo].[vw_CRM_AccountEntity_API] AS U ON A.WHAccountID = u.[APIAccount]
	LEFT OUTER JOIN DynamicsODS.[dbo].[vw_CRM_AccountEntity_User] AS c ON c.[accountid] = u.[accountid]
	LEFT OUTER JOIN Medispan.dbo.DrugMaster AS d ON a.NDC = d.NDC 
	WHERE A.InvDate >= @StartInvDate
	AND A.InvDate < @EndInvDate
	AND A.WHAccountID IN('42093133'
						, '42123200'
						, '42155181'
						, '42192634'
						, '42208467'
						, '42035000'
						, '42132644'
						, '12137541'
						, '42214444'
						, '42083061'
						)
	OR EXISTS(SELECT 1
				FROM RXMaster.dbo.PharmacyDim AS p
				WHERE p.NCPDP = '4908832'
				AND a.WHAccountID = p.[APINumber]
						)
	ORDER BY a.[WHAccountID] ASC

END
GO
