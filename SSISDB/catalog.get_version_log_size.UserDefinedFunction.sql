USE [SSISDB]
GO
/****** Object:  UserDefinedFunction [catalog].[get_version_log_size]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [catalog].[get_version_log_size]()
RETURNS bigint
AS 
BEGIN
    DECLARE @value bigint
    SELECT @value = internal.get_space_used('internal.object_versions')
    RETURN @value
END
GO
