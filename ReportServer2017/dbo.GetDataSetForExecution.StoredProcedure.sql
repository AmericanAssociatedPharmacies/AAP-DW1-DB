USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDataSetForExecution]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDataSetForExecution]
@ItemID uniqueidentifier,
@ParamsHash int
AS
DECLARE @now AS datetime
SET @now = GETDATE()
SELECT
    SN.SnapshotDataID,
    SN.EffectiveParams,
    SN.QueryParams,
    (SELECT CachePolicy.ExpirationFlags FROM CachePolicy WHERE CachePolicy.ReportID = Cat.ItemID),
    Cat.Property
FROM
    Catalog AS Cat
    LEFT OUTER JOIN
    (
        SELECT
        TOP 1
            ReportID,
            SN.SnapshotDataID,
            EffectiveParams,
            QueryParams
        FROM [ReportServer2017TempDB].dbo.ExecutionCache AS EC
        INNER JOIN [ReportServer2017TempDB].dbo.SnapshotData AS SN ON EC.SnapshotDataID = SN.SnapshotDataID AND EC.ParamsHash = SN.ParamsHash
        WHERE
            AbsoluteExpiration > @now
            AND SN.ParamsHash = @ParamsHash
            AND EC.ReportID = @ItemID
        ORDER BY SN.CreatedDate DESC
    ) as SN ON Cat.ItemID = SN.ReportID
WHERE
    Cat.ItemID = @ItemID
GO
