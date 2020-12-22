USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[WriteChunkPortion]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WriteChunkPortion]
@ChunkPointer binary(16),
@IsPermanentSnapshot bit,
@DataIndex int = NULL,
@DeleteLength int = NULL,
@Content image
AS

IF @IsPermanentSnapshot != 0 BEGIN
    UPDATETEXT ChunkData.Content @ChunkPointer @DataIndex @DeleteLength @Content
END ELSE BEGIN
    UPDATETEXT [aapssrs01_ReportServerTempDB].dbo.ChunkData.Content @ChunkPointer @DataIndex @DeleteLength @Content
END
GO
