USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Evaluations]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Evaluations](
	[Source] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[For] [nvarchar](255) NULL,
	[Date Saved] [nvarchar](8) NULL,
	[Item Nbr] [nvarchar](255) NULL,
	[Item Desc] [nvarchar](255) NULL,
	[Unit] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[Contract] [nvarchar](255) NULL,
	[Program] [nvarchar](255) NULL,
	[Qty] [int] NULL,
	[API Price] [money] NULL,
	[STORE] [money] NULL,
	[AWP] [money] NULL,
	[NET] [money] NULL,
	[PERCENTDIFF] [float] NULL,
	[DOLLARDIFF] [money] NULL,
	[LastUpdated] [datetime] NULL
) ON [PRIMARY]
GO
