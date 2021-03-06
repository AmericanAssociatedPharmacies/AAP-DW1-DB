USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[ProviderRelationship]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProviderRelationship](
	[ProviderRelationshipKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[RelationshipID] [varchar](3) NULL,
	[PaymentCenterID] [varchar](6) NULL,
	[RemitandReconciliationID] [varchar](6) NULL,
	[ProviderType] [varchar](2) NULL,
	[IsPrimary] [varchar](1) NULL,
	[EffectiveFromDate] [varchar](8) NULL,
	[EffectiveThroughDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ProviderRelationship] PRIMARY KEY CLUSTERED 
(
	[ProviderRelationshipKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProviderRelationship] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
