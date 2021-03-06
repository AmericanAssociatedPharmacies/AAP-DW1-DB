USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[RECOMPILE_ALL_VIEWS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: 7-1-2010
-- Description:	recompile all SP's and views
-- =============================================
CREATE PROCEDURE [dbo].[RECOMPILE_ALL_VIEWS]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- recompile all stored procs and refresh all views.
--SELECT * FROM SYSOBJECTS ORDER BY NAME
DECLARE @objName VARCHAR(100)
DECLARE @SQL VARCHAR(800)
SET	@objName = ''

WHILE	@objName IS NOT NULL
	BEGIN
		SELECT @objName = MIN( Name )
		FROM	SysObjects
		WHERE	[Type]='V' AND
			Name > @objName

		IF	@objName IS NOT NULL
				BEGIN
					BEGIN TRY
						exec sp_refreshview @objName	
					END TRY 
					BEGIN CATCH	
					END CATCH
				 END
				--print @objname
END

-- Reports database views
	SET	@objName = ''

	WHILE	@objName IS NOT NULL
		BEGIN
			SELECT @objName = MIN( Name )
			FROM	reports..SysObjects
			WHERE	[Type]='V' AND
				Name > @objName

			IF	@objName IS NOT NULL
				BEGIN
					BEGIN TRY
						exec reports..sp_refreshview @objName	
					END TRY 
					BEGIN CATCH	
					END CATCH
				 END
					--print @objname
	END

-- Webdev database views
	SET	@objName = ''

	WHILE	@objName IS NOT NULL
		BEGIN
			SELECT @objName = MIN( Name )
			FROM	Webdev..SysObjects
			WHERE	[Type]='V' AND
				Name > @objName

			IF	@objName IS NOT NULL
				BEGIN
					BEGIN TRY
						exec Webdev..sp_refreshview @objName	
					END TRY 
					BEGIN CATCH	
					END CATCH
				 END
					--print @objname
	END
END

-- ALTER PROCEDURE dbo.RefreshAllViews
--AS
--DECLARE @ViewName NVARCHAR(1024)
--DECLARE @Result NVARCHAR(MAX)
--DECLARE @Results TABLE (ViewName NVARCHAR(1024), Result NVARCHAR(MAX))
--DECLARE myViews CURSOR FOR SELECT [name] AS ViewName FROM sys.views V
--
--OPEN myViews FETCH NEXT FROM myViews INTO @ViewName
--
--WHILE @@FETCH_STATUS = 0
--BEGIN
--SET @Result = ‘Successfully refreshed’
--
--BEGIN TRY
--EXEC sp_refreshview @ViewName
--END TRY BEGIN CATCH
--SET @Result = error_message()
--ROLLBACK TRANSACTION /*avoids trancount error*/
--END CATCH
--
--INSERT INTO @Results VALUES(@ViewName, @Result)
--FETCH NEXT FROM myViews INTO @ViewName
--END
--
--SELECT * FROM @Results
--
--CLOSE myViews
--DEALLOCATE myViews 
--
--GO


 
GO
