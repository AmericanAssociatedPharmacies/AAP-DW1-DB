USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_APISalesDetail_AS400Pull_ETL]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_APISalesDetail_AS400Pull_ETL]


AS

BEGIN


	DECLARE @MaxDate DATETIME
	, @CurrentDate DATETIME

	SELECT @MaxDate = MAX(InvDate)
	FROM dbo.APISalesDetail

	SET @CurrentDate = DATEADD(DAY, 0, DATEDIFF(DAY, 0, GETDATE()))

	--Get data

	SELECT dt.WHAccountID
	, dt.InvNbr
	, dt.InvLine
	, dt.CustomerName
	, dt.APIItemNbr
	, dt.ItemDescription
	, dt.Qty
	, dt.UnitAmt
	, dt.ItermGrp
	, dt.AcctGrp
	, dt.Territory
	, dt.InvDate
	, dt.LineAmt
	, dt.ExtSales
	, dt.OrderNbr
	, dt.NDC_orig
	, dt.NDC
	, dt.DateLoaded
	, dt.Type
	, dt.WHNbr
	FROM(SELECT LTRIM(RTRIM(WHAccountID)) AS WHAccountID
			, LTRIM(RTRIM(InvNbr)) AS InvNbr
			, LTRIM(RTRIM(InvLine)) AS InvLine
			, LTRIM(RTRIM(CustomerName)) AS CustomerName
			, LTRIM(RTRIM(APIItemNbr)) AS APIItemNbr
			, LTRIM(RTRIM(ItemDescription)) AS ItemDescription
			, LTRIM(RTRIM(Qty)) AS Qty
			, LTRIM(RTRIM(UnitAmt)) AS UnitAmt
			, LTRIM(RTRIM(ItermGrp)) AS ItermGrp
			, LTRIM(RTRIM(AcctGrp)) AS AcctGrp
			, LTRIM(RTRIM(Territory)) AS Territory
			, LTRIM(RTRIM(InvDate)) AS InvDate
			, LTRIM(RTRIM(LineAmt)) AS LineAmt
			, LTRIM(RTRIM(ExtSales)) AS ExtSales
			, LTRIM(RTRIM(OrderNbr)) AS OrderNbr
			, LTRIM(RTRIM(NDC_orig)) AS NDC_orig
			, LTRIM(RTRIM(NDC)) AS NDC
			, LTRIM(RTRIM(DateLoaded)) AS DateLoaded
			, LTRIM(RTRIM(Type)) AS Type
			, LTRIM(RTRIM(WHNbr)) AS WHNbr
			FROM [sales].[v_Import_API_WH_Sales]
			WHERE CONVERT(DATETIME, InvDate) > @MaxDate
			AND CONVERT(DATETIME, InvDate) < @CurrentDate
	) AS dt
	

END


GO
