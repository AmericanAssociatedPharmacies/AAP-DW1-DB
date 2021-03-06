USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Nova_20180611]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nova_20180611](
	[NDC] [nvarchar](255) NULL,
	[Ordered] [float] NULL,
	[F3] [float] NULL,
	[Shipped] [float] NULL,
	[Extended] [money] NULL,
	[Brand] [nvarchar](255) NULL,
	[Generic] [nvarchar](255) NULL,
	[CIN] [nvarchar](255) NULL,
	[MF] [nvarchar](255) NULL,
	[Strength] [nvarchar](255) NULL,
	[F11] [nvarchar](255) NULL,
	[Size] [nvarchar](255) NULL,
	[F13] [nvarchar](255) NULL
) ON [PRIMARY]
GO
