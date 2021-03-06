USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity_CAH]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity_CAH](
	[CAHKey] [int] IDENTITY(1,1) NOT NULL,
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
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [timestamp] NOT NULL,
	[new_cah_account2] [nvarchar](100) NULL,
	[new_cah_account3] [nvarchar](100) NULL,
	[new_cahcsosaccount] [nvarchar](100) NULL,
	[new_cahposaccount] [nvarchar](100) NULL,
	[new_cahstaccount] [nvarchar](250) NULL,
	[new_cahdepositaccount] [nvarchar](100) NULL,
	[new_cahdmeaccount] [nvarchar](100) NULL,
	[new_cahotcaccount] [nvarchar](100) NULL,
	[new_cahspecialtyaccount] [nvarchar](100) NULL,
	[new_cahcomboaccount] [nvarchar](100) NULL,
	[new_cahgenericrebate] [decimal](28, 0) NULL,
	[new_cahhighvolumerebate] [decimal](28, 0) NULL,
 CONSTRAINT [CPK_CRM_AccountEntity_CAH] PRIMARY KEY CLUSTERED 
(
	[CAHKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_CRM_AccountEntity_CAH] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRM_AccountEntity_CAH] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
