USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ReadRoleProperties]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadRoleProperties]
@RoleName as nvarchar(260)
AS
SELECT Description, TaskMask, RoleFlags FROM Roles WHERE RoleName = @RoleName
GO
