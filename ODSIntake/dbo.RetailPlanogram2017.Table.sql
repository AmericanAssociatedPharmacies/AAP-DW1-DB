USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RetailPlanogram2017]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RetailPlanogram2017](
	[2017] [nvarchar](255) NULL,
	[2018] [nvarchar](255) NULL,
	[AccountName] [nvarchar](255) NULL,
	[Address1] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[ST] [nvarchar](255) NULL,
	[Zip] [float] NULL,
	[Terr] [float] NULL,
	[Type] [nvarchar](255) NULL,
	[Subtype] [nvarchar](255) NULL,
	[Planogram] [nvarchar](255) NULL,
	[AAP ID] [float] NULL,
	[API ID] [float] NULL,
	[AAP Elite] [nvarchar](255) NULL,
	[FullName] [nvarchar](255) NULL,
	[2016 Rebate] [money] NULL,
	[2016 Delta %] [float] NULL,
	[2017 Rebate] [money] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
GO
