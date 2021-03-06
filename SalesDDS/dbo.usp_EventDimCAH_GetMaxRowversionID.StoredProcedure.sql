USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_EventDimCAH_GetMaxRowversionID]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_EventDimCAH_GetMaxRowversionID]

AS

SET NOCOUNT ON;


BEGIN

	DECLARE @pbinin VARBINARY(MAX)
	, @MaxRowversionID VARCHAR(50)

	SELECT @pbinin = MAX([RowversionID_DB1]) 
	FROM [dbo].[EventDimCAH]

	--SET @pbinin = 0x000000000002DADE	
	SELECT @MaxRowversionID = master.dbo.fn_varbintohexstr(@pbinin)

	SELECT dt.MaxrowversionID
	FROM(SELECT @MaxRowversionID  AS MaxrowversionID	
		) AS dt


END
GO
