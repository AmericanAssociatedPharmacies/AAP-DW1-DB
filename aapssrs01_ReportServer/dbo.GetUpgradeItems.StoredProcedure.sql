USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetUpgradeItems]    Script Date: 12/22/2020 5:44:05 AM ******/
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
