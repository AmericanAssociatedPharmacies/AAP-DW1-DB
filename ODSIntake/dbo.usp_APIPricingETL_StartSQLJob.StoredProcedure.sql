USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIPricingETL_StartSQLJob]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_APIPricingETL_StartSQLJob]

AS

SET NOCOUNT ON;

BEGIN
	
	EXEC msdb.dbo.sp_start_job N'API Pricing ETL' 


END
GO
