USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[CleanExpiredEditSessions]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[CleanExpiredEditSessions]
    @MaxToClean int = 10,
    @NumCleaned int OUTPUT
AS BEGIN
    SET DEADLOCK_PRIORITY LOW

    declare @now datetime;
    select @now = GETDATE();

    declare @DeletedItems table (ItemID uniqueidentifier not null primary key, Intermediate uniqueidentifier null)
    declare @DeletedCacheSnapshots table (SnapshotDataID uniqueidentifier null)

    begin transaction
        insert into @DeletedItems
        select top(@MaxToClean) TempCatalogID, Intermediate
        from [ReportServer2017TempDB].dbo.TempCatalog TC WITH(UPDLOCK)
        where ExpirationTime < @now and not exists (
            select 1
            from [ReportServer2017TempDB].dbo.SessionData SD WITH (INDEX (IX_EditSessionID))
            where SD.EditSessionID = TC.EditSessionID ) ;

        delete from [ReportServer2017TempDB].dbo.TempDataSources
        where ItemID in (
            select ItemID from @DeletedItems ) ;

        delete from [ReportServer2017TempDB].dbo.TempDataSets
        where ItemID in (
            select ItemID from @DeletedItems ) ;

        delete from [ReportServer2017TempDB].dbo.TempCatalog
        where TempCatalogID in (
            select ItemID from @DeletedItems ) ;

        delete from [ReportServer2017TempDB].dbo.ExecutionCache
        output deleted.SnapshotDataID into @DeletedCacheSnapshots(SnapshotDataID)
        where ReportID in (
            select ItemID from @DeletedItems );

        update [ReportServer2017TempDB].dbo.SnapshotData
        set PermanentRefcount = PermanentRefcount - 1
        where SnapshotData.SnapshotDataID in
            (select Intermediate from @DeletedItems
             union
             select SnapshotDataID from @DeletedCacheSnapshots) ;
    commit

    select @NumCleaned = count(1) from @DeletedItems ;
END
GO
