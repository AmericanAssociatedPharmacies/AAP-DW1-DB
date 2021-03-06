USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2MOD_N]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2MOD_N](
	[Modifier_Code] [varchar](6) NOT NULL,
	[Modifier_Description] [nvarchar](25) NULL,
	[Reserve] [nvarchar](24) NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Last_Change_Date] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Modifier_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
