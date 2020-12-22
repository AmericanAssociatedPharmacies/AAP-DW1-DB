USE [ODSIntake]
GO
/****** Object:  Table [dbo].[NADAC_Config]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NADAC_Config](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[URLDownload] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[NADAC_Config] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
