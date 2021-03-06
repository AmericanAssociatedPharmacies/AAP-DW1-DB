USE [SSISDB]
GO
/****** Object:  StoredProcedure [catalog].[set_customized_logging_level_description]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [catalog].[set_customized_logging_level_description]
    @level_name NVARCHAR(128),
    @level_description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON
    
    
    IF (IS_MEMBER('ssis_admin') = 0)
        AND (IS_SRVROLEMEMBER('sysadmin') = 0)
    BEGIN
        RAISERROR(27239, 16, 1) WITH NOWAIT
        RETURN 1
    END
    
    IF @level_name IS NULL
    BEGIN
        RAISERROR(27233, 16, 1) WITH NOWAIT
        RETURN 1
    END
    
    UPDATE [internal].[customized_logging_levels]
    SET [description] = @level_description
    WHERE [name] = @level_name
        
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR(27237, 16, 1, @level_name) WITH NOWAIT
        RETURN 1
    END
    ELSE 
    BEGIN
        RETURN 0
    END
END
GO
