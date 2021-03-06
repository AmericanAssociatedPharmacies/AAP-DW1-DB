USE [ODSIntake]
GO
/****** Object:  Table [Archive].[CRM_AccountEntity_CAH]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[CRM_AccountEntity_CAH](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_cah_account] [nvarchar](100) NULL,
	[new_cah_avg_volume] [int] NULL,
	[new_cah_cog] [decimal](28, 0) NULL,
	[new_cah_dso] [decimal](28, 0) NULL,
	[new_cah_potential_volume] [int] NULL,
	[new_cah_terms] [int] NULL,
	[new_cah_termsname] [nvarchar](250) NULL,
	[new_cahpvacontractdate] [date] NULL,
	[new_cahpvaeffdatenewagreement] [date] NULL,
	[new_cahpvalastreview] [date] NULL,
	[new_cahpvamatrix] [int] NULL,
	[new_cahpvamatrixname] [nvarchar](250) NULL,
	[new_cahpvareviewtype] [int] NULL,
	[new_cahpvareviewtypename] [nvarchar](250) NULL,
	[new_cahpvastatus] [int] NULL,
	[new_cahpvastatusname] [nvarchar](250) NULL,
	[new_cahpvatermcode] [int] NULL,
	[new_cahpvatermcodename] [nvarchar](250) NULL,
	[new_cahpvatermcomment] [nvarchar](250) NULL,
	[new_cahpvatermdate] [date] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DateKey] [int] NULL,
	[StagingRowCreatedDate] [datetime] NOT NULL,
	[new_cahstaccount] [nvarchar](250) NULL,
	[new_cahdepositaccount] [nvarchar](100) NULL,
	[new_cahdmeaccount] [nvarchar](100) NULL,
	[new_cahotcaccount] [nvarchar](100) NULL,
	[new_cahspecialtyaccount] [nvarchar](100) NULL,
	[new_cahcomboaccount] [nvarchar](100) NULL,
 CONSTRAINT [CPK_Archive_CRM_AccountEntity_CAH] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[CRM_AccountEntity_CAH] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
