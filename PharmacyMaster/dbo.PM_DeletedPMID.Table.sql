USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_DeletedPMID]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_DeletedPMID](
	[PK_DeletedPMID] [int] IDENTITY(1,1) NOT NULL,
	[Deleted_PMID] [int] NULL,
	[MovedTo_PMID] [int] NULL,
	[Reason] [varchar](255) NULL,
	[DeletedDate] [datetime] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_DeletedPMID] PRIMARY KEY CLUSTERED 
(
	[PK_DeletedPMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_DeletedPMID] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_DeletedPMID] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_DeletedPMID] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
