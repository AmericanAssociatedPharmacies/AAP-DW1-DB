USE [SSISDB]
GO
/****** Object:  StoredProcedure [internal].[deploy_project_internal]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [internal].[deploy_project_internal]
	@deploy_id [bigint],
	@version_id [bigint],
	@project_id [bigint],
	@project_name [nvarchar](128)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[DeployProjectInternal]
GO
