USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity_ScanToss]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity_ScanToss](
	[ScanTossKey] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_scantoss_activation_date] [date] NULL,
	[new_scantoss_app_received_date] [date] NULL,
	[new_scantoss_eligible_date] [date] NULL,
	[new_scantoss_status] [int] NULL,
	[new_scantoss_statusname] [nvarchar](250) NULL,
	[new_scantoss_version] [int] NULL,
	[new_scantoss_versionname] [nvarchar](250) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [timestamp] NOT NULL,
 CONSTRAINT [CPK_Staging_CRM_AccountEntity_ScanToss] PRIMARY KEY CLUSTERED 
(
	[ScanTossKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_CRM_AccountEntity_ScanToss] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRM_AccountEntity_ScanToss] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
