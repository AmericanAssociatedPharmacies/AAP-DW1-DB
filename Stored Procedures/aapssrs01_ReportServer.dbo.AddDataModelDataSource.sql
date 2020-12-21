USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[AddDataModelDataSource] Script Date: 12/21/2020 8:25:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddDataModelDataSource]
    @ItemID uniqueidentifier,
    @DSType int = 0,
    @DSKind int = 0,
    @AuthType int = 0,
    @ConnectionString varbinary(max) = null,
    @Username varbinary(max) = null,
    @Password varbinary(max) = null
AS
BEGIN
INSERT
    INTO DataModelDataSource
        ([ItemID],
        [DSType],
        [DSKind],
        [AuthType],
        [ConnectionString],
        [Username],
        [Password])
    VALUES
        (@ItemID,
        @DSType,
        @DSKind,
        @AuthType,
        @ConnectionString,
        @Username,
        @Password)
END
