USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[RECOMPILE_ALL]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: 7-1-2010
-- Description:	recompile all SP's and views
-- =============================================
CREATE PROCEDURE [dbo].[RECOMPILE_ALL]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- recompile all stored procs and refresh all views.
--SELECT * FROM SYSOBJECTS ORDER BY NAME
DECLARE @objName VARCHAR(100)
SET	@objName = ''

WHILE	@objName IS NOT NULL
	BEGIN
		SELECT @objName = MIN( Name )
		FROM	SysObjects
		WHERE	[Type]='V' AND
			Name > @objName

		IF	@objName IS NOT NULL
				exec sp_refreshview @objName		
				--print @objname
END
SET	@objName = ''

WHILE	@objName IS NOT NULL
	BEGIN
		SELECT @objName = MIN( Name )
		FROM	SysObjects
		WHERE	[Type]='P' and xtype = 'P' and
			Name > @objName

		IF	@objName IS NOT NULL
				exec sp_recompile @objName		
				--print 'U-' + @objname
END
END



GO
