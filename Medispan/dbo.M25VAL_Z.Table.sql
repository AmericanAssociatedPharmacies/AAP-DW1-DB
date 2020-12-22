USE [Medispan]
GO
/****** Object:  Table [dbo].[M25VAL_Z]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M25VAL_Z](
	[Field_Identifier] [varchar](4) NULL,
	[Field_Value] [varchar](15) NULL,
	[Language_Code] [numeric](37, 0) NULL,
	[Value_Description] [varchar](40) NULL,
	[Value_Abbreviation] [varchar](15) NULL,
	[Reserve] [varchar](20) NULL
) ON [PRIMARY]
GO
