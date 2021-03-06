USE [SSISDB]
GO
/****** Object:  UserDefinedFunction [internal].[decrypt_binarydata]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [internal].[decrypt_binarydata](@algorithmName [nvarchar](255), @key [varbinary](8000), @IV [varbinary](8000), @binary_value [varbinary](max))
RETURNS [varbinary](max) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.Security.CryptoGraphy].[DecryptBinaryData]
GO
