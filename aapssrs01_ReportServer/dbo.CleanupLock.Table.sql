USE [aapssrs01_ReportServer]
GO
/****** Object:  Table [dbo].[CleanupLock]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CleanupLock](
	[ID] [int] NOT NULL,
	[MachineName] [nvarchar](256) NULL,
	[LockDate] [datetime] NOT NULL,
 CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
