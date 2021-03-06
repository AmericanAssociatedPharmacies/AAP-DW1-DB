USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[HZDCLASS_B]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HZDCLASS_B](
	[Class_ID] [int] NOT NULL,
	[Transaction_CD] [nvarchar](1) NULL,
	[Class_Name] [nvarchar](500) NULL,
	[NIOSH_Group_CD] [nvarchar](6) NULL,
	[Reserve] [nvarchar](65) NULL,
PRIMARY KEY CLUSTERED 
(
	[Class_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
