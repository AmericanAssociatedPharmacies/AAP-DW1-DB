USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ST_Nova_20190711]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ST_Nova_20190711](
	[Territory] [nvarchar](255) NULL,
	[Pharmacy Name] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[Main Phone] [nvarchar](255) NULL,
	[AAP #] [nvarchar](255) NULL,
	[AAP Effective] [datetime] NULL,
	[AAP Parent #] [nvarchar](255) NULL,
	[API #] [nvarchar](255) NULL,
	[Combined Volume] [float] NULL,
	[Primary Contact] [nvarchar](255) NULL,
	[PMID] [nvarchar](255) NULL,
	[APICredit] [money] NULL
) ON [PRIMARY]
GO
