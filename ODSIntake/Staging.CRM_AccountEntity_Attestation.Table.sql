USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CRM_AccountEntity_Attestation]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CRM_AccountEntity_Attestation](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_primaryattestation] [date] NULL,
	[new_primaryattestationrequired] [bit] NULL,
	[new_primaryattestationrequiredname] [nvarchar](250) NULL,
	[new_primaryattestationsent] [date] NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CRM_AccountEntity_Attestation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
