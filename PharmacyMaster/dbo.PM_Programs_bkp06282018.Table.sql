USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Programs_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Programs_bkp06282018](
	[ProgramID] [int] NOT NULL,
	[Description] [varchar](50) NULL,
	[CommentConst] [varchar](255) NULL,
	[Category] [char](1) NULL,
	[AAP] [smallint] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
	[WebProfile] [smallint] NOT NULL,
 CONSTRAINT [PK_PM_Programs] PRIMARY KEY CLUSTERED 
(
	[ProgramID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_Programs_bkp06282018] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_Programs_bkp06282018] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_Programs_bkp06282018] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
ALTER TABLE [dbo].[PM_Programs_bkp06282018] ADD  DEFAULT ((0)) FOR [WebProfile]
GO
