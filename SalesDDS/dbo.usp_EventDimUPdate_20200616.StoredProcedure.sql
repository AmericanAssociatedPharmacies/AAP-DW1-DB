USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimUPdate_20200616]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_EventDimUPdate_20200616]

	@DateKey INT

AS

BEGIN

	UPDATE x
	SET [CAHType] = c.CAHType
	, Brand = c.Brand
	FROM dbo.EventDimCAH AS x
	INNER JOIN [dbo].[CAH_20200616] AS c ON x.CHPH_AAP_ID = c.ID
	WHERE x.DateKey = @DateKey


END
GO
