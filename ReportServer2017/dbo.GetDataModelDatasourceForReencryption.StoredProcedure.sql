USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDataModelDatasourceForReencryption]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
