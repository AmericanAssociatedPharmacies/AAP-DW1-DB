USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDataModelDataSourcesByItemID] Script Date: 12/21/2020 9:10:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDataModelDataSourcesByItemID]
    @ItemID uniqueidentifier
AS
    SELECT
        D.DSID,
        D.ItemId,
        D.DSType,
        D.DSKind,
        D.AuthType,
        D.ConnectionString,
        D.Username,
        D.Password
    FROM
        [DataModelDataSource] as D
    WHERE
        D.[ItemID] = @ItemID
