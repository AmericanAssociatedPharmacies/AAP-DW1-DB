USE [SSISDB]
GO
/****** Object:  StoredProcedure [internal].[stop_operation_internal]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [internal].[stop_operation_internal]
	@operation_id [bigint],
	@process_id [int],
	@operation_guid [uniqueidentifier]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[StopOperationInternal]
GO
