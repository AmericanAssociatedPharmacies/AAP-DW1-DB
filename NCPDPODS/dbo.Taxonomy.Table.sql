USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[Taxonomy]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taxonomy](
	[TaxonomyKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[TaxonomyCode] [varchar](10) NULL,
	[ProviderTypeCode] [varchar](2) NULL,
	[DeleteDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Taxonomy] PRIMARY KEY CLUSTERED 
(
	[TaxonomyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Taxonomy] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
