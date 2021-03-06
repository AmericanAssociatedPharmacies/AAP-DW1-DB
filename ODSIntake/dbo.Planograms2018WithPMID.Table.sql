USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Planograms2018WithPMID]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Planograms2018WithPMID](
	[(Do Not Modify) Account] [nvarchar](255) NULL,
	[(Do Not Modify) Row Checksum] [nvarchar](255) NULL,
	[(Do Not Modify) Modified On] [datetime] NULL,
	[PMID] [nvarchar](255) NULL,
	[Pharmacy Name] [nvarchar](255) NULL,
	[Primary Contact] [nvarchar](255) NULL,
	[Street 1] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL
) ON [PRIMARY]
GO
