USE [SSISDB]
GO
/****** Object:  StoredProcedure [internal].[clean_update_packages]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [internal].[clean_update_packages]
        @project_id             bigint,
        @project_version_lsn    bigint
WITH EXECUTE AS 'AllSchemaOwner'
AS
    SET NOCOUNT ON

    DECLARE @result bit
    EXECUTE AS CALLER   
        SET @result = [internal].[check_permission] 
        (
            2,
            @project_id,
            2
        ) 
    REVERT

    IF @result = 0
    BEGIN
        RAISERROR(27109 , 16 , 1, @project_id) WITH NOWAIT
        RETURN 1
    END
     
    DELETE FROM [internal].[packages]
    WHERE [project_id] = @project_id AND [project_version_lsn] = @project_version_lsn
GO
