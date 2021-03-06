USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[ListInfoForReencryption]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListInfoForReencryption]
@ConfigNames AS [dbo].[EncryptedConfigList] READONLY
AS

SELECT [DSID]
FROM [dbo].[DataSource] WITH (XLOCK, TABLOCK)

SELECT [SubscriptionID]
FROM [dbo].[Subscriptions] WITH (XLOCK, TABLOCK)

SELECT [InstallationID], [PublicKey]
FROM [dbo].[Keys] WITH (XLOCK, TABLOCK)
WHERE [Client] = 1 AND ([SymmetricKey] IS NOT NULL)

SELECT [Name],[Value]
FROM [dbo].[ConfigurationInfo]
WHERE [Name] IN (SELECT [ConfigName] FROM @ConfigNames)

SELECT [UserID]
FROM [dbo].[Users]
WHERE ([ServiceToken] IS NOT NULL)

SELECT [DSID]
FROM [dbo].[DataModelDataSource]
GO
