USE [SSISDB]
GO
/****** Object:  View [catalog].[environment_variables]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [catalog].[environment_variables]
AS
SELECT     [variable_id], 
           [environment_id], 
           [name],
           [description],
           [type], 
           [sensitive], 
           [value]
FROM       [internal].[environment_variables]
WHERE      [environment_id] in (SELECT [id] FROM [internal].[current_user_readable_environments])
           OR (IS_MEMBER('ssis_admin') = 1)
           OR (IS_SRVROLEMEMBER('sysadmin') = 1)
GO
