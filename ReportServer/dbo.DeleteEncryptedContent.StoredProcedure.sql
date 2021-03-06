USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[DeleteEncryptedContent]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteEncryptedContent]
AS

-- Remove the encryption keys
delete from keys where client >= 0

-- Remove the encrypted content
UPDATE [dbo].[DataSource]
SET CredentialRetrieval = 1, -- CredentialRetrieval.Prompt
    ConnectionString = null,
    OriginalConnectionString = null,
    UserName = null,
    Password = null;

-- Remove all PowerBI fields from ConfigurationInfo since without ClientSecret you can't properly reregister.
Delete FROM [dbo].[ConfigurationInfo]
WHERE Name IN ('ClientId', 'AppObjectId', 'TenantName', 'TenantId', 'ClientSecret', 'ResourceUrl', 'AuthorizationUrl', 'TokenUrl', 'RedirectUrls')

UPDATE [dbo].[Users]
SET [ServiceToken] = null

-- Remove KPIs since they are encrypted; Catalog Type=11 is KPI
UPDATE [dbo].[Catalog]
SET [Property] = null
WHERE [Type] = 11
GO
