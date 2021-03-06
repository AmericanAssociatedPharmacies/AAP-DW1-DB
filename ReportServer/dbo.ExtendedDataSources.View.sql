USE [ReportServer]
GO
/****** Object:  View [dbo].[ExtendedDataSources]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[ExtendedDataSources]
AS
SELECT
	DSID, ItemID, SubscriptionID, Name, Extension, Link,
	CredentialRetrieval, Prompt, ConnectionString,
	OriginalConnectionString, OriginalConnectStringExpressionBased,
	UserName, Password, Flags, Version
FROM DataSource
UNION ALL
SELECT
	DSID, ItemID, NULL as [SubscriptionID], Name, Extension, Link,
	CredentialRetrieval, Prompt, ConnectionString,
	OriginalConnectionString, OriginalConnectStringExpressionBased,
	UserName, Password, Flags, Version
FROM [ReportServerTempDB].dbo.TempDataSources
GO
