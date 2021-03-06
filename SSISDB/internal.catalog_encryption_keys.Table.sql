USE [SSISDB]
GO
/****** Object:  Table [internal].[catalog_encryption_keys]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[catalog_encryption_keys](
	[key_id] [bigint] IDENTITY(1,1) NOT NULL,
	[key_name] [nvarchar](255) NOT NULL,
	[KEY] [varbinary](8000) NOT NULL,
	[IV] [varbinary](8000) NOT NULL,
 CONSTRAINT [PK_Encryption_Keys] PRIMARY KEY CLUSTERED 
(
	[key_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
