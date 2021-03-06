USE [WebDev]
GO
/****** Object:  Table [dbo].[CA_CheckResultsHistory]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CA_CheckResultsHistory](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [bigint] NOT NULL,
	[IsOIGListed] [nvarchar](1) NOT NULL,
	[IsSAMListed] [nvarchar](1) NOT NULL,
	[CheckedBy] [nvarchar](64) NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_CA_CheckResultsHistory] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CA_CheckResultsHistory] ADD  CONSTRAINT [DF_CA_CheckResultsHistory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[CA_CheckResultsHistory] ADD  CONSTRAINT [DF_CA_CheckResultsHistory_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
