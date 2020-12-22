USE [aapssrs01_ReportServerTempDB]
GO
/****** Object:  StoredProcedure [dbo].[GetDBVersion]    Script Date: 12/22/2020 5:58:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[GetDBVersion]
    @DBVersion nvarchar(32) OUTPUT
    AS
    SET @DBVersion = (select top(1) [DbVersion]  from [dbo].[DBUpgradeHistory])
GO
