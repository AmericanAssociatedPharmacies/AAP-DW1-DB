USE [SSISDB]
GO
/****** Object:  StoredProcedure [internal].[create_execution_dump_internal]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [internal].[create_execution_dump_internal]
	@execution_id [bigint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[CreateExecutionDumpInternal]
GO
