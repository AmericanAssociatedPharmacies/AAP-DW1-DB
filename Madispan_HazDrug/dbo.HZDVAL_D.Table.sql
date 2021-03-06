USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[HZDVAL_D]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HZDVAL_D](
	[File_Name] [varchar](200) NOT NULL,
	[Field_Name] [varchar](200) NOT NULL,
	[Field_Value] [varchar](50) NOT NULL,
	[Value_Description] [nvarchar](160) NULL,
	[Value_Abbreviation] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[File_Name] ASC,
	[Field_Name] ASC,
	[Field_Value] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
