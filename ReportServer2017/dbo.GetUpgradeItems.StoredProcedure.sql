USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetUpgradeItems]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUpgradeItems]
AS
SELECT
    [Item],
    [Status]
FROM
    [UpgradeInfo]
GO
