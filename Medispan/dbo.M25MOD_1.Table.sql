USE [Medispan]
GO
/****** Object:  Table [dbo].[M25MOD_1]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25MOD_1](
	[Modifier_Code] [varchar](6) NULL,
	[Modifier_Description] [varchar](25) NULL,
	[Transaction_Code] [varchar](1) NULL,
	[Last_Change_Date] [varchar](8) NULL,
	[Reserve] [varchar](24) NULL
) ON [PRIMARY]
GO
