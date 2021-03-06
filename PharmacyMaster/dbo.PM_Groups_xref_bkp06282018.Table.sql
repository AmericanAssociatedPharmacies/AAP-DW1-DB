USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Groups_xref_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Groups_xref_bkp06282018](
	[Grpxref_ID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[Group_ID] [int] NOT NULL,
	[Source] [varchar](5) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_Groups_xref] PRIMARY KEY CLUSTERED 
(
	[Grpxref_ID] ASC,
	[PMID] ASC,
	[Group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_Groups_xref_bkp06282018] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_Groups_xref_bkp06282018] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_Groups_xref_bkp06282018] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
