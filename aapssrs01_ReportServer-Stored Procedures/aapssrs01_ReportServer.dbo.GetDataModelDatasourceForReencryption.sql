USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDataModelDatasourceForReencryption] Script Date: 12/21/2020 9:09:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDataModelDatasourceForReencryption]
@DSID as bigint
AS

SELECT
    [ConnectionString],
    [Username],
    [Password]
FROM [dbo].[DataModelDataSource]
WHERE [DSID] = @DSID
