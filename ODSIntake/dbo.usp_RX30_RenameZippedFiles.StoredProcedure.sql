USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_RX30_RenameZippedFiles]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_RX30_RenameZippedFiles]

	 @FileDir VARCHAR(500)

AS

SET NOCOUNT ON

BEGIN

DECLARE @Exists INT


SELECT dt.CurrentFileName
, ca.CorrectFileName
FROM(SELECT FilePath AS CurrentFileName
		, FileDirectory
		, REPLACE(FileName, '.csv.csv', '.csv') AS C1
		FROM [dbo].[mtvf_GetFileInfo](@filedir)
		) AS dt
CROSS APPLY(SELECT (dt.FileDirectory + dt.C1) AS CorrectFileName
						) AS ca

END


GO
