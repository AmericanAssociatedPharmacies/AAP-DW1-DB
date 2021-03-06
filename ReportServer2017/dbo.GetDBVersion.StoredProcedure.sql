USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetDBVersion]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[GetDBVersion]
    @DBVersion nvarchar(32) OUTPUT
    AS
    SET @DBVersion = (select top(1) [ServerVersion] from [dbo].[ServerUpgradeHistory] ORDER BY [UpgradeID] DESC)
GO
