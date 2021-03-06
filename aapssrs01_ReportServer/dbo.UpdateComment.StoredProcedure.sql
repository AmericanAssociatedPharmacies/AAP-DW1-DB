USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[UpdateComment]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateComment]
@Text nvarchar(2048),
@CommentID bigint
AS
BEGIN
    UPDATE
        [Comments]
    SET
        [Text]=@Text,
        [ModifiedDate]=GETDATE()
    WHERE
        [CommentID]=@CommentID
END
GO
