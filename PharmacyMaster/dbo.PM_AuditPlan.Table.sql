USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_AuditPlan]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_AuditPlan](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditPlan] [nvarchar](50) NULL
) ON [PRIMARY]
GO
