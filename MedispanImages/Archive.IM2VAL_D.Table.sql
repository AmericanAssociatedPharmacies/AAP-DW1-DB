USE [MedispanImages]
GO
/****** Object:  Table [Archive].[IM2VAL_D]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[IM2VAL_D](
	[Field_Identifier] [varchar](4) NOT NULL,
	[Field_Value] [varchar](15) NOT NULL,
	[Language_Code] [int] NOT NULL,
	[Value_Description] [nvarchar](40) NULL,
	[Value_Abbreviation] [nvarchar](15) NULL,
	[Reserve] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Field_Identifier] ASC,
	[Field_Value] ASC,
	[Language_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
