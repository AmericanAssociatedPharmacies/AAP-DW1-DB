USE [ODSIntake]
GO
/****** Object:  StoredProcedure [dbo].[usp_Delete_Record]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[usp_Delete_Record] 

@FileProcessed VARCHAR(1000)

AS

SET NOCOUNT ON

DELETE
FROM Archive.Rx30Claims
WHERE FileProcessed = @FileProcessed
GO
