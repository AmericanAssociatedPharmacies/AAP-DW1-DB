USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetSnapshotChunks]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSnapshotChunks]
@SnapshotDataID uniqueidentifier,
@IsPermanentSnapshot bit
AS

IF @IsPermanentSnapshot != 0 BEGIN

SELECT ChunkName, ChunkType, ChunkFlags, MimeType, Version, datalength(Content)
FROM ChunkData
WHERE
    SnapshotDataID = @SnapshotDataID

END ELSE BEGIN

SELECT ChunkName, ChunkType, ChunkFlags, MimeType, Version, datalength(Content)
FROM [aapssrs01_ReportServerTempDB].dbo.ChunkData
WHERE
    SnapshotDataID = @SnapshotDataID
END
GO
