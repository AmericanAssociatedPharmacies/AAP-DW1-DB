USE [SSISDB]
GO
/****** Object:  Table [internal].[catalog_properties]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[catalog_properties](
	[property_name] [nvarchar](256) NOT NULL,
	[property_value] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_ISServer_Property] PRIMARY KEY CLUSTERED 
(
	[property_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
