USE [SalesDDS]
GO
/****** Object:  StoredProcedure [Staging].[usp_Get_EventDimCAH_Dates]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [Staging].[usp_Get_EventDimCAH_Dates]

AS

SET NOCOUNT ON;

BEGIN


	SELECT RN, DateKey
	FROM Staging.CAH_DatesToLoad
	ORDER BY RN ASC, DateKey ASC
	

END





GO
