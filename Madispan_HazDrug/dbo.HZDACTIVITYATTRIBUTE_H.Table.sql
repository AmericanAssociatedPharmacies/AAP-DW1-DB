USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[HZDACTIVITYATTRIBUTE_H]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HZDACTIVITYATTRIBUTE_H](
	[Activity_ID] [int] NOT NULL,
	[Attribute_Type] [varchar](50) NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Attribute_Value] [nvarchar](255) NULL,
	[Attribute_Value_Description] [nvarchar](255) NULL,
	[Reserve] [nvarchar](65) NULL,
PRIMARY KEY CLUSTERED 
(
	[Activity_ID] ASC,
	[Attribute_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
