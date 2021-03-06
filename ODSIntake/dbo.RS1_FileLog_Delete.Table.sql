USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RS1_FileLog_Delete]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RS1_FileLog_Delete](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_RS1_FileLog_Delete] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RS1_FileLog_Delete] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
