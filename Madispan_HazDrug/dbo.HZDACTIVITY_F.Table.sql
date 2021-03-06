USE [Medispan_HazDrug]
GO
/****** Object:  Table [dbo].[HZDACTIVITY_F]    Script Date: 12/22/2020 7:14:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HZDACTIVITY_F](
	[Activity_ID] [int] NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Activity_Name] [nvarchar](500) NULL,
	[Parent_ID] [nvarchar](10) NULL,
	[Reserve] [nvarchar](65) NULL,
PRIMARY KEY CLUSTERED 
(
	[Activity_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
