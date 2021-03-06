USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetChunkPointerAndLength]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetChunkPointerAndLength]
@SnapshotDataID uniqueidentifier,
@IsPermanentSnapshot bit,
@ChunkName nvarchar(260),
@ChunkType int
AS
IF @IsPermanentSnapshot != 0 BEGIN

    SELECT
       TEXTPTR(Content),
       DATALENGTH(Content),
       MimeType,
       ChunkFlags,
       Version
    FROM
       ChunkData AS CH
    WHERE
       SnapshotDataID = @SnapshotDataID AND
       ChunkName = @ChunkName AND
       ChunkType = @ChunkType

END ELSE BEGIN

    SELECT
       TEXTPTR(Content),
       DATALENGTH(Content),
       MimeType,
       ChunkFlags,
       Version
    FROM
       [ReportServer2017TempDB].dbo.ChunkData AS CH
    WHERE
       SnapshotDataID = @SnapshotDataID AND
       ChunkName = @ChunkName AND
       ChunkType = @ChunkType

END
GO
