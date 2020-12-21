USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetCommentsByItemID] Script Date: 12/21/2020 9:05:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCommentsByItemID]
@ItemID uniqueidentifier
AS
BEGIN
    SELECT
        C.[CommentID],
        C.[ItemID],
        U.[UserName],
        C.[ThreadID],
        C.[Text],
        C.[CreatedDate],
        C.[ModifiedDate],
        CA.[Path] AS AttachmentPath
    FROM
        [Comments] as C
        INNER JOIN Users as U ON C.[UserID] = U.[UserID]
        LEFT JOIN Catalog as CA ON C.[AttachmentID] = CA.[ItemID]
    WHERE
        C.[ItemID] = @ItemID
END
