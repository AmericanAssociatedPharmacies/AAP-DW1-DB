USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ReadChunkPortion]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadChunkPortion]
@ChunkPointer binary(16),
@IsPermanentSnapshot bit,
@DataIndex int,
@Length int
AS

IF @IsPermanentSnapshot != 0 BEGIN
    READTEXT ChunkData.Content @ChunkPointer @DataIndex @Length
END ELSE BEGIN
    READTEXT [aapssrs01_ReportServerTempDB].dbo.ChunkData.Content @ChunkPointer @DataIndex @Length
END
GO
