USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetCommentByCommentID]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCommentByCommentID]
@CommentID bigint
AS
BEGIN
    SELECT TOP(1)
        C.[CommentID],
        C.[ItemID],
        U.[UserName],
        C.[ThreadID],
        C.[Text],
        C.[CreatedDate],
        C.[ModifiedDate],
        CAI.[Path] AS ItemPath,
        CAA.[Path] AS AttachmentPath,
        CAI.[Name]
    FROM
        [Comments] as C
        INNER JOIN Users as U ON C.[UserID] = U.[UserID]
        INNER JOIN Catalog as CAI ON C.[ItemID] = CAI.[ItemID]
        LEFT JOIN Catalog as CAA ON C.[AttachmentID] = CAA.[ItemID]
    WHERE
        C.[CommentID] = @CommentID
END
GO
