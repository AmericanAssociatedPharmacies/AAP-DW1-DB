USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_MemberComm]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_MemberComm](
	[PMID] [int] NOT NULL,
	[CommID] [int] NOT NULL,
	[Email] [varchar](max) NULL,
	[AlternateFax] [varchar](255) NULL,
	[UseFaxNotEmail] [bit] NULL,
	[OptOut] [bit] NULL,
	[CommunicationPreference] [varchar](1) NULL,
 CONSTRAINT [PK_PM_MemberComm] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC,
	[CommID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_MemberComm] ADD  CONSTRAINT [DF_PM_MemberComm_UseFaxNotEmail]  DEFAULT ((0)) FOR [UseFaxNotEmail]
GO
ALTER TABLE [dbo].[PM_MemberComm] ADD  CONSTRAINT [DF_PM_MemberComm_OptOut]  DEFAULT ((0)) FOR [OptOut]
GO
