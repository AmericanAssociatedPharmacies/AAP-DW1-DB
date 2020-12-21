USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDataSourceForUpgrade] Script Date: 12/21/2020 9:10:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetDataSourceForUpgrade]
@CurrentVersion int
AS
SELECT
    [DSID]
FROM
    [DataSource]
WHERE
    [Version] != @CurrentVersion
