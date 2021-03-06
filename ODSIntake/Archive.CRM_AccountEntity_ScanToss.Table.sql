USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CRM_AccountEntity_ScanToss]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CRM_AccountEntity_ScanToss](
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
	[StagingRowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_CRM_AccountEntity_ScanToss] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CRM_AccountEntity_ScanToss] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
