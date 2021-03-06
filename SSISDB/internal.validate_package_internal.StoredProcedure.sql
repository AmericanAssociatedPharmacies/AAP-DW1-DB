USE [SSISDB]
GO
/****** Object:  StoredProcedure [internal].[validate_package_internal]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [internal].[validate_package_internal]
	@project_id [bigint],
	@package_id [bigint],
	@version_id [bigint],
	@validation_id [bigint],
	@environment_scope [nchar](1),
	@use32bitruntime [smallint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[ValidatePackageInternal]
GO
