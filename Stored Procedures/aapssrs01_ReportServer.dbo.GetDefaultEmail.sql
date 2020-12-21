USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDefaultEmail] Script Date: 12/21/2020 9:11:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDefaultEmail]
    @UserID uniqueidentifier
AS
BEGIN
    SELECT TOP(1)
        U.[DefaultEmailAddress]
    FROM
        [UserContactInfo] as U
    WHERE
        U.UserID = @UserID
END
