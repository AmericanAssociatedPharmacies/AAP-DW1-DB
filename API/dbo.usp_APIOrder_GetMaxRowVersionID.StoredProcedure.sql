USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIOrder_GetMaxRowVersionID]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_APIOrder_GetMaxRowVersionID]

AS

SET NOCOUNT ON;

BEGIN

	DECLARE @pbinin VARBINARY(MAX)
	, @MaxRowversionID VARCHAR(50)

	SELECT @pbinin = MAX([RowversionID]) 
	FROM [dbo].[APIOrder]

	SELECT @MaxRowversionID = master.dbo.fn_varbintohexstr(@pbinin)

	SELECT dt.MaxrowversionID
	FROM(SELECT @MaxRowversionID AS MaxrowversionID	
		) AS dt
		

END

GO
