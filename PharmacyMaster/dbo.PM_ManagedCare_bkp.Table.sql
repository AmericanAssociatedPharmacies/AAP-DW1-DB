USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_ManagedCare_bkp]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_ManagedCare_bkp](
	[PK_ManagedCare] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NULL,
	[MCEffectiveDate] [datetime] NULL,
	[MCQuitDate] [datetime] NULL,
	[ChainCode] [int] NULL,
	[ArgusAgree] [smallint] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_ManagedCare_bkp] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_ManagedCare_bkp] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_ManagedCare_bkp] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
