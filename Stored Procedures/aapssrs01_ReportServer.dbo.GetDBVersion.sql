USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetDBVersion] Script Date: 12/21/2020 9:11:38 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


    CREATE PROCEDURE [dbo].[GetDBVersion]
    @DBVersion nvarchar(32) OUTPUT
    AS
    SET @DBVersion = (select top(1) [ServerVersion] from [dbo].[ServerUpgradeHistory] ORDER BY [UpgradeID] DESC)
