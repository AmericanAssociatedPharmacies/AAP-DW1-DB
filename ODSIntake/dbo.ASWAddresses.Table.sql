USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ASWAddresses]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ASWAddresses](
	[API#] [nvarchar](255) NULL,
	[Pharmacy] [nvarchar](255) NULL,
	[Address1] [nvarchar](255) NULL,
	[Address2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL
) ON [PRIMARY]
GO
