USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[ePrescribingInformation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ePrescribingInformation](
	[ePrescribingInformationKey] [int] IDENTITY(1,1) NOT NULL,
	[NCPDPProviderID] [varchar](7) NULL,
	[ePrescribingNetworkIdentifier] [varchar](10) NULL,
	[ePrescribingServiceLevelCodes] [varchar](100) NULL,
	[EffectiveFromDate] [varchar](8) NULL,
	[EffectiveThroughDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ePrescribingInformation] PRIMARY KEY CLUSTERED 
(
	[ePrescribingInformationKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ePrescribingInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
