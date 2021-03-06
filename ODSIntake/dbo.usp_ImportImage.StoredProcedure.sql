USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_ImportImage]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_ImportImage] 
	
     @PicName NVARCHAR (100)
   , @ImageFolderPath NVARCHAR (1000)
   , @Filename NVARCHAR (1000)
   
AS

SET NOCOUNT ON

BEGIN
   
   DECLARE @tsql NVARCHAR (2000);
   
   

   SET @tsql = 'insert into Pictures (pictureName, picFileName, PictureData) ' +
               ' SELECT ' + '''' + @PicName + '''' + ',' + '''' + @Filename + '''' + ', * ' + 
               'FROM Openrowset( Bulk ' + '''' + @ImageFolderPath + '''' + ', Single_Blob) as img'
   EXEC (@tsql)

   
END
GO
