USE [ODSIntake]
GO
/****** Object:  Table [dbo].[BARNABAS_RetailSpend0519_0719DaveS]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BARNABAS_RetailSpend0519_0719DaveS](
	[Source] [nvarchar](255) NULL,
	[Facility] [nvarchar](255) NULL,
	[Billing Document Number] [float] NULL,
	[Billing Date] [datetime] NULL,
	[National Drug Code (NDC)] [nvarchar](255) NULL,
	[Material Description] [nvarchar](255) NULL,
	[Normalization UOM] [nvarchar](255) NULL,
	[Material Form] [nvarchar](255) NULL,
	[Units Invoiced] [float] NULL,
	[Unit Cost] [money] NULL,
	[Total Invoice Amount] [money] NULL,
	[Annualized] [money] NULL
) ON [PRIMARY]
GO
