USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[UpdateSnapshotReferences]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSnapshotReferences]
    @OldSnapshotId UNIQUEIDENTIFIER,
    @NewSnapshotId UNIQUEIDENTIFIER,
    @IsPermanentSnapshot BIT,
    @TransientRefCountModifier INT,
    @UpdatedReferences INT OUTPUT
AS
BEGIN
    SET @UpdatedReferences = 0

    IF(@IsPermanentSnapshot = 1)
    BEGIN
        -- Update Snapshot Executions
        UPDATE [dbo].[Catalog]
        SET [SnapshotDataID] = @NewSnapshotId
        WHERE [SnapshotDataID] = @OldSnapshotId

        SELECT @UpdatedReferences = @UpdatedReferences + @@ROWCOUNT

        -- Update History
        UPDATE [dbo].[History]
        SET [SnapshotDataID] = @NewSnapshotId
        WHERE [SnapshotDataID] = @OldSnapshotId

        SELECT @UpdatedReferences = @UpdatedReferences + @@ROWCOUNT

        UPDATE [dbo].[SnapshotData]
        SET [PermanentRefcount] = [PermanentRefcount] - @UpdatedReferences,
            [TransientRefcount] = [TransientRefcount] + @TransientRefCountModifier
        WHERE [SnapshotDataID] = @OldSnapshotId

        UPDATE [dbo].[SnapshotData]
        SET [PermanentRefcount] = [PermanentRefcount] + @UpdatedReferences
        WHERE [SnapshotDataID] = @NewSnapshotId
    END
    ELSE
    BEGIN
        -- Update Execution Cache
        UPDATE [aapssrs01_ReportServerTempDB].dbo.[ExecutionCache]
        SET [SnapshotDataID] = @NewSnapshotId
        WHERE [SnapshotDataID] = @OldSnapshotId

        SELECT @UpdatedReferences = @UpdatedReferences + @@ROWCOUNT

        UPDATE [aapssrs01_ReportServerTempDB].dbo.[SnapshotData]
        SET [PermanentRefcount] = [PermanentRefcount] - @UpdatedReferences,
            [TransientRefcount] = [TransientRefcount] + @TransientRefCountModifier
        WHERE [SnapshotDataID] = @OldSnapshotId

        UPDATE [aapssrs01_ReportServerTempDB].dbo.[SnapshotData]
        SET [PermanentRefcount] = [PermanentRefcount] + @UpdatedReferences
        WHERE [SnapshotDataID] = @NewSnapshotId
    END
END
GO
