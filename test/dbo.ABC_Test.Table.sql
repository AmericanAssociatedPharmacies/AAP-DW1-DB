USE [test]
GO
/****** Object:  Table [dbo].[ABC_Test]    Script Date: 12/22/2020 8:07:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABC_Test](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[C1] [varchar](500) NULL,
	[C2] [varchar](500) NULL,
	[C3] [varchar](500) NULL,
	[C4] [varchar](500) NULL,
	[C5] [varchar](500) NULL,
	[C6] [varchar](500) NULL,
	[C7] [varchar](500) NULL,
	[C8] [varchar](500) NULL,
	[C9] [varchar](500) NULL,
	[C10] [varchar](500) NULL,
	[C12] [varchar](500) NULL,
	[C13] [varchar](500) NULL,
	[C14] [varchar](500) NULL,
	[C15] [varchar](500) NULL,
	[C16] [varchar](500) NULL,
	[C17] [varchar](500) NULL,
	[C18] [varchar](500) NULL,
	[C19] [varchar](500) NULL,
	[C20] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ABC_Test] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
