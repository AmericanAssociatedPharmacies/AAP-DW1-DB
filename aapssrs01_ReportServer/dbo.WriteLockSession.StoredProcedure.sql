USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[WriteLockSession]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[WriteLockSession]
@SessionID as varchar(32),
@Persisted bit,
@CheckLockVersion bit = 0,
@LockVersion int
AS
SET NOCOUNT OFF ;
IF @Persisted = 1
BEGIN
    IF @CheckLockVersion = 0
    BEGIN
        UPDATE [aapssrs01_ReportServerTempDB].dbo.SessionLock WITH (ROWLOCK)
        SET SessionID = SessionID
        WHERE SessionID = @SessionID;
    END
    ELSE
    BEGIN
        DECLARE @ActualLockVersion as int

        UPDATE [aapssrs01_ReportServerTempDB].dbo.SessionLock WITH (ROWLOCK)
        SET SessionID = SessionID,
        LockVersion = LockVersion + 1
        WHERE SessionID = @SessionID
        AND LockVersion = @LockVersion ;

        IF (@@ROWCOUNT = 0)
        BEGIN
            SELECT @ActualLockVersion = LockVersion
            FROM [aapssrs01_ReportServerTempDB].dbo.SessionLock WITH (ROWLOCK)
            WHERE SessionID = @SessionID;

            IF (@ActualLockVersion <> @LockVersion)
                RAISERROR ('Invalid version locked', 16,1)
            END
        END
    END
ELSE
BEGIN
    INSERT INTO [aapssrs01_ReportServerTempDB].dbo.SessionLock WITH (ROWLOCK) (SessionID) VALUES (@SessionID)
END
GO
