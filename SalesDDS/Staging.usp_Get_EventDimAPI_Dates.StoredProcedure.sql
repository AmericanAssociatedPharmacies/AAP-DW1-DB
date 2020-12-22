USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Get_EventDimAPI_Dates]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [Staging].[usp_Get_EventDimAPI_Dates]

AS

SET NOCOUNT ON;

BEGIN

	SELECT RN, Datekey
	FROM Staging.API_DatesToLoad
	ORDER BY DateKey ASC, RN ASC

END



GO
