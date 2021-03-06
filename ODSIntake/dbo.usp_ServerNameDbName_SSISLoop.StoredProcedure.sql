USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ServerNameDbName_SSISLoop]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ServerNameDbName_SSISLoop]

AS

SET NOCOUNT ON

BEGIN

	MERGE [dbo].[ServerNameDbName_SSISLoop] t 
    USING [staging].[ServerNameDbName_SSISLoop] s
          ON (s.ServerName = t.ServerName and s.DBname = t.DBName)

WHEN NOT MATCHED BY TARGET THEN 
	
	INSERT (ServerName, DBname)
    VALUES (s.ServerName, s.DBname)

WHEN NOT MATCHED BY SOURCE THEN 
	DELETE;

END
GO
