USE [ODSIntake]
GO
/****** Object:  Table [dbo].[AAP_CustomerFormularyReports]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AAP_CustomerFormularyReports](
	[CIN] [float] NULL,
	[NDC] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Supplier Name] [nvarchar](255) NULL,
	[Cardkey] [nvarchar](255) NULL,
	[GCN] [nvarchar](255) NULL,
	[GCN_SEQ] [float] NULL,
	[GPI Code] [nvarchar](255) NULL,
	[UD_ID] [nvarchar](255) NULL,
	[Strength] [nvarchar](255) NULL,
	[Accunet Size] [float] NULL,
	[UOM] [nvarchar](255) NULL,
	[Form] [nvarchar](255) NULL,
	[Form Description] [nvarchar](255) NULL,
	[Color] [nvarchar](255) NULL,
	[Shape] [nvarchar](255) NULL,
	[Brand/Generic (CGIC)] [float] NULL,
	[TEE Rating] [nvarchar](255) NULL,
	[DEA Schedule Number] [float] NULL,
	[NIFO] [float] NULL,
	[Sell Price] [float] NULL,
	[Sell Price Per Unit] [float] NULL,
	[Generic Name] [nvarchar](255) NULL,
	[Brand Name] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Formulary Name] [nvarchar](255) NULL,
	[END_DTE] [datetime] NULL
) ON [PRIMARY]
GO
