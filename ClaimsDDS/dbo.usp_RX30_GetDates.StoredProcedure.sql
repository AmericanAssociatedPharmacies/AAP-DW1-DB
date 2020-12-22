USE [ClaimsDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_RX30_GetDates]    Script Date: 12/22/2020 6:54:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RX30_GetDates]

AS

SET NOCOUNT ON;

BEGIN

	SELECT RN, DateKey
	FROM [Staging].[RX30_DatesToLoad]

END
GO
