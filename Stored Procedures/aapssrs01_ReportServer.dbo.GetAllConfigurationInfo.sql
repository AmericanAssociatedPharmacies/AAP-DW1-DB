USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAllConfigurationInfo] Script Date: 12/21/2020 8:58:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllConfigurationInfo]
AS
SELECT [Name], [Value]
FROM [ConfigurationInfo]
