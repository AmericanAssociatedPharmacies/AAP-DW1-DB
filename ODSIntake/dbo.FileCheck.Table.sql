USE [ODSIntake]
GO
/****** Object:  Table [dbo].[FileCheck]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileCheck](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FilePath] [varchar](500) NULL,
	[FileName] [varchar](250) NULL,
	[DoesFileExist] [bit] NOT NULL,
	[VerifiedDate] [datetime] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FileCheck] ADD  DEFAULT ((0)) FOR [DoesFileExist]
GO
ALTER TABLE [dbo].[FileCheck] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
