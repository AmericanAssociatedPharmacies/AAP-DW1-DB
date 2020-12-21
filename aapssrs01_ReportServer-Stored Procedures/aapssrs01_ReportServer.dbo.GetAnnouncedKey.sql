USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAnnouncedKey] Script Date: 12/21/2020 8:59:21 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAnnouncedKey]
@InstallationID uniqueidentifier
AS

select PublicKey, MachineName, InstanceName
from Keys
where InstallationID = @InstallationID and Client = 1
