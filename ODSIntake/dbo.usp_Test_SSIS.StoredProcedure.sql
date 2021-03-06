USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Test_SSIS]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Test_SSIS]

AS

SET NOCOUNT ON;

BEGIN

DECLARE @intExecutionID BIGINT

EXEC [SSISDB].[catalog].[create_execution] 
	@folder_name = 'KPI'
	, @Project_name = 'KPI_AllyScripts'
	, @package_name = 'KPI_AllyScripts_ODSIntake_DataLoad.dtsx'
	, @use32bitruntime = FALSE
	, @execution_id = @intExecutionID OUT

EXEC [SSISDB].[catalog].[start_execution] @intExecutionID

END
GO
