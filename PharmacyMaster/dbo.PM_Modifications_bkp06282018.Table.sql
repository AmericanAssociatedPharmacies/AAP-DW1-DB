USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Modifications_bkp06282018]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Modifications_bkp06282018](
	[PMID] [int] NOT NULL,
	[ModDate] [datetime] NOT NULL,
	[ModType] [varchar](10) NULL,
	[Reason] [varchar](100) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_Modifications] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC,
	[ModDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_Modifications_bkp06282018] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_Modifications_bkp06282018] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_Modifications_bkp06282018] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
