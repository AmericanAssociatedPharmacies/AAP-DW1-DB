USE [aapssrs01_ReportServer]
GO
/****** Object:  UserDefinedTableType [dbo].[EncryptedConfigList]    Script Date: 12/22/2020 5:44:04 AM ******/
CREATE TYPE [dbo].[EncryptedConfigList] AS TABLE(
	[ConfigName] [nvarchar](256) NULL
)
GO
