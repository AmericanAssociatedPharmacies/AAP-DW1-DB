USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetClientSecret]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetClientSecret]
@ClientSecret nvarchar (260)
AS

UPDATE [dbo].[ConfigurationInfo]
SET [Value] = @ClientSecret
WHERE [Name] = 'ClientSecret'
GO
