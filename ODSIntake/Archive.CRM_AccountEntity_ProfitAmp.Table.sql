USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CRM_AccountEntity_ProfitAmp]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CRM_AccountEntity_ProfitAmp](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_profitampactivationdate] [date] NULL,
	[new_profitampapplicationemail] [nvarchar](100) NULL,
	[new_profitampapplicationname] [nvarchar](100) NULL,
	[new_profitampapplicationreceived] [date] NULL,
	[new_profitampapplicationtitle] [nvarchar](100) NULL,
	[new_profitamplevel] [int] NULL,
	[new_profitamplevelname] [nvarchar](250) NULL,
	[new_profitampsenderemail] [int] NULL,
	[new_profitampsenderemailname] [nvarchar](250) NULL,
	[new_profitampsent] [date] NULL,
	[new_profitamptermination] [date] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NULL,
	[StagingRowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Archive_CRM_AccountEntity_ProfitAmp] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CRM_AccountEntity_ProfitAmp] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
