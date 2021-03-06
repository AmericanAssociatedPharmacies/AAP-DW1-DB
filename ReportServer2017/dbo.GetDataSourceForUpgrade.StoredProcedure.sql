USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDataSourceForUpgrade]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
