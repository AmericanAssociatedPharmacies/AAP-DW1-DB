USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[usp_API_Medispan]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_API_Medispan]

AS

SET NOCOUNT ON;

BEGIN

	SELECT dt.NDC
	, dt.[Desc]
	, dt.Strength
	, dt.Unit
	, dt.Size
	, dt.GPI
	, dt.AWP
	FROM(SELECT NDC, [Desc], Strength, Unit, Size, GPI, AWP
			FROM [dbo].[vw_API]
			) AS dt

END
GO
