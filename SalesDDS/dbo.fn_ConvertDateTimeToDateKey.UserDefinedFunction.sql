USE [SalesDDS]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_ConvertDateTimeToDateKey]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select  CAST(CONVERT(VARCHAR(20),@testdate,112) as INT)

CREATE FUNCTION [dbo].[fn_ConvertDateTimeToDateKey](@Date DATETIME)
RETURNS INT

AS

BEGIN

	DECLARE @DateKey INT

	SET @DateKey = CAST(CONVERT(VARCHAR(20),@Date,112) as INT)

	RETURN(@DateKey);



END
GO
