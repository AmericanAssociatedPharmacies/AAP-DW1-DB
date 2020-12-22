USE [ODSIntake]
GO
/****** Object:  Table [dbo].[NovaBrandComparison_20180830]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NovaBrandComparison_20180830](
	[Universal NDC] [nvarchar](255) NULL,
	[Drug Name] [nvarchar](255) NULL,
	[Qty] [float] NULL,
	[Per Unit] [money] NULL,
	[Total Cost] [money] NULL
) ON [PRIMARY]
GO
