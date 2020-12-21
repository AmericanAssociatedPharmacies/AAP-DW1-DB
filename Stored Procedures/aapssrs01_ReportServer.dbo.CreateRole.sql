USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CreateRole] Script Date: 12/21/2020 8:38:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateRole]
@RoleID as uniqueidentifier,
@RoleName as nvarchar(260),
@Description as nvarchar(512) = null,
@TaskMask as nvarchar(32),
@RoleFlags as tinyint
AS
INSERT INTO Roles
(RoleID, RoleName, Description, TaskMask, RoleFlags)
VALUES
(@RoleID, @RoleName, @Description, @TaskMask, @RoleFlags)
