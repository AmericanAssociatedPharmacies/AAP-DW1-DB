USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CRM_AccountEntity_ScanToss]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CRM_AccountEntity_ScanToss](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
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
 CONSTRAINT [CPK_Staging_CRM_AccountEntity_ScanToss] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CRM_AccountEntity_ScanToss] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
