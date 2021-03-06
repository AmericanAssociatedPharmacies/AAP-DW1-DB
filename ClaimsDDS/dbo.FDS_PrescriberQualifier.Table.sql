USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDS_PrescriberQualifier]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDS_PrescriberQualifier](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](3) NULL,
	[Description] [varchar](100) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_FDS_PrescriberQualifier] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FDS_PrescriberQualifier] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
