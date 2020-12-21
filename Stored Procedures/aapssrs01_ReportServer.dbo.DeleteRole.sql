USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteRole] Script Date: 12/21/2020 8:50:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Delete all policies associated with this role
CREATE PROCEDURE [dbo].[DeleteRole]
@RoleName nvarchar(260)
AS
SET NOCOUNT OFF
-- if you call this, you must delete/reconstruct all policies associated with this role
DELETE FROM Roles WHERE RoleName = @RoleName
