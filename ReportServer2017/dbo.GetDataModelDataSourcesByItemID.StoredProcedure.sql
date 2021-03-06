USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDataModelDataSourcesByItemID]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
