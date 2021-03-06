USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetConfigurationInfoValue]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetConfigurationInfoValue]
@ConfigValue nvarchar (260),
@ConfigName nvarchar (260)
AS

UPDATE [dbo].[ConfigurationInfo]
SET [Value] = @ConfigValue
WHERE [Name] = @ConfigName
GO
