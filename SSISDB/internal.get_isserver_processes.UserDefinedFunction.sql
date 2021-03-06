USE [SSISDB]
GO
/****** Object:  UserDefinedFunction [internal].[get_isserver_processes]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [internal].[get_isserver_processes]()
RETURNS  TABLE (
	[process_id] [bigint] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.StartupApi].[GetISServerProcesses]
GO
