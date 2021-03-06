USE [MedispanImages_Staging]
GO
/****** Object:  StoredProcedure [dbo].[usp_DropUserTables]    Script Date: 12/22/2020 7:21:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_DropUserTables]

AS

SET NOCOUNT ON;

BEGIN


	DECLARE @p1 VARCHAR(4000)


	DECLARE C1 CURSOR FOR
	SELECT dt.C1
	FROM(SELECT CONVERT(VARCHAR(4000), 'DROP TABLE ' + OBJECT_SCHEMA_NAME(id) + '.' + name) AS C1
		FROM sys.sysobjects
		WHERE type = 'u'
		) AS dt

	OPEN C1

	FETCH NEXT
	FROM C1
	INTO @p1

	WHILE @@FETCH_STATUS = 0
	BEGIN

		EXEC (@p1)

		FETCH NEXT
		FROM C1
		INTO @p1


	END

	CLOSE C1
	DEALLOCATE C1

END
GO
