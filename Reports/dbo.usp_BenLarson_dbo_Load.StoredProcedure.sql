USE [Reports]
GO
/****** Object:  StoredProcedure [dbo].[usp_BenLarson_dbo_Load]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[usp_BenLarson_dbo_Load]

AS

SET NOCOUNT ON;

BEGIN

	INSERT [dbo].[BenLarson](PMID, WHAccountID, InvNbr, InvDate, APIItemNbr, NDC, PackSize, ItemDescription, Qty, UnitAmount, ExtSales, Type, ItemGrp, FileSource)
	SELECT PMID, WHAccountID, InvNbr, InvDate, APIItemNbr, NDC, PackSize, ItemDescription, Qty, UnitAmount, ExtSales, Type, ItemGrp, FileSource
	FROM [Staging].[BenLarson] AS s
	WHERE NOT EXISTS(SELECT 1
					FROM [dbo].[BenLarson] AS d
					WHERE s.WHAccountID = d.WHAccountID
					AND s.InvNbr = d.InvNbr
					AND s.InvDate = s.InvDate
					)

END


GO
