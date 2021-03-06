USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PharmacyPlus_CustomerFormularyReport]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmacyPlus_CustomerFormularyReport](
	[CIN] [float] NULL,
	[NDC] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[Supplier Name] [nvarchar](255) NULL,
	[Strength] [nvarchar](255) NULL,
	[Accunet Size] [float] NULL,
	[UOM] [nvarchar](255) NULL,
	[Form] [nvarchar](255) NULL,
	[Form Description] [nvarchar](255) NULL,
	[CONTRACT PRICE] [float] NULL,
	[Generic Name] [nvarchar](255) NULL,
	[Brand Name] [nvarchar](255) NULL,
	[Status] [nvarchar](255) NULL,
	[Formulary Name] [nvarchar](255) NULL,
	[END_DTE] [datetime] NULL
) ON [PRIMARY]
GO
