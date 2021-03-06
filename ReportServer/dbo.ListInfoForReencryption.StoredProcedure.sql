USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[ListInfoForReencryption]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListInfoForReencryption]
AS

SELECT [DSID]
FROM [dbo].[DataSource] WITH (XLOCK, TABLOCK)

SELECT [SubscriptionID]
FROM [dbo].[Subscriptions] WITH (XLOCK, TABLOCK)

SELECT [InstallationID], [PublicKey]
FROM [dbo].[Keys] WITH (XLOCK, TABLOCK)
WHERE [Client] = 1 AND ([SymmetricKey] IS NOT NULL)

SELECT [Value]
FROM [dbo].[ConfigurationInfo]
WHERE [Name] = 'ClientSecret'

SELECT [UserID]
FROM [dbo].[Users]
WHERE ([ServiceToken] IS NOT NULL)
GO
