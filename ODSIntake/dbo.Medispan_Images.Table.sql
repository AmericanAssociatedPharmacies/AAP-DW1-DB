USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Medispan_Images]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medispan_Images](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Content] [image] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Medispan_Images] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
