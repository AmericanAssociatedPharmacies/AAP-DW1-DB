USE [CAHODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_CAH_NDC_Update]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_CAH_NDC_Update]
AS

SET NOCOUNT ON;

Begin
--Update for IsGenericCAH column
	--DrugMaster
	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [DrugMaster].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [DrugMaster].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'
	
	--ClaimsDDS
	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [ClaimsDDS].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [ClaimsDDS].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'

	--Pricing
	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [Pricing].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [Pricing].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'

	--SalesDDS
	--Generics
	UPDATE x
	SET IsCAHGeneric =  1
	FROM [SalesDDS].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'N'

	--Brands
	UPDATE x
	SET IsCAHGeneric =  0
	FROM [SalesDDS].[dbo].[DrugDim] AS x
	INNER JOIN CAHODS.[dbo].[CAH_NDC] AS c ON x.NDC = c.NDC
	WHERE c.Brand = 'B'

END


				

GO
