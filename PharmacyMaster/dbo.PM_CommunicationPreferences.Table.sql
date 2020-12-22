USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_CommunicationPreferences]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_CommunicationPreferences](
	[commPreference] [varchar](1) NOT NULL,
	[Description] [varchar](20) NULL,
 CONSTRAINT [PK_PM_CommunicationPreferences] PRIMARY KEY CLUSTERED 
(
	[commPreference] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
