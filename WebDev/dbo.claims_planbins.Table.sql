USE [WebDev]
GO
/****** Object:  Table [dbo].[claims_planbins]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[claims_planbins](
	[BIN] [nvarchar](50) NOT NULL,
	[PlanName] [nvarchar](200) NULL,
	[PlanKey] [nvarchar](50) NULL,
	[Email] [nvarchar](100) NULL,
	[UPC] [int] NULL
) ON [PRIMARY]
GO
