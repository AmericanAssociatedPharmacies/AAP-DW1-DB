USE [DynamicsODS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DynamicsODS_Activities_GetMaxDates_ETL]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DynamicsODS_Activities_GetMaxDates_ETL]

AS


SET NOCOUNT ON;

BEGIN

	
	SELECT dt.MaxCreatedOn
	, dt.MaxModifiedOn
	FROM(SELECT CONVERT(DATETIME,ISNULL(MAX([createdon]), '19000101')) AS MaxCreatedOn
		, CONVERT(DATETIME, ISNULL(MAX([modifiedon]),'19000101')) AS MaxModifiedOn
		FROM [dbo].[CRM_Activities]
		) AS dt

END
GO
