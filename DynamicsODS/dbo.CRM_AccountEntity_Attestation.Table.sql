USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity_Attestation]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity_Attestation](
	[AttKey] [int] IDENTITY(1,1) NOT NULL,
	[accountid] [uniqueidentifier] NULL,
	[new_primaryattestation] [date] NULL,
	[new_primaryattestationrequired] [bit] NULL,
	[new_primaryattestationrequiredname] [nvarchar](250) NULL,
	[new_primaryattestationsent] [date] NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
 CONSTRAINT [CPK_CRM_AccountEntity_Attestation] PRIMARY KEY CLUSTERED 
(
	[AttKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_CRM_AccountEntity_Attestation] UNIQUE NONCLUSTERED 
(
	[accountid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRM_AccountEntity_Attestation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
