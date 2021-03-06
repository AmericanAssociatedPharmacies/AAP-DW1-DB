USE [ODSIntake]
GO
/****** Object:  Table [dbo].[APINDCToMatch]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APINDCToMatch](
	[API NDC] [nvarchar](255) NULL,
	[API GPI] [nvarchar](255) NULL,
	[API DRUG NAME] [nvarchar](255) NULL,
	[API FORM] [nvarchar](255) NULL,
	[API SIZE] [nvarchar](255) NULL,
	[API MFG] [nvarchar](255) NULL,
	[TARGET NDC] [nvarchar](255) NULL,
	[TARGET MFG] [nvarchar](255) NULL,
	[Product Name] [nvarchar](255) NULL,
	[Form] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[MFG] [nvarchar](255) NULL
) ON [PRIMARY]
GO
