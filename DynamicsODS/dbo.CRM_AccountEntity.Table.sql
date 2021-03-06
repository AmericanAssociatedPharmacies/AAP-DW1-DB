USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[CRM_AccountEntity]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CRM_AccountEntity](
	[AddressKey] [int] NOT NULL,
	[APIKey] [int] NOT NULL,
	[CAHKey] [int] NOT NULL,
	[ProfitAmpKey] [int] NOT NULL,
	[ScanTossKey] [int] NOT NULL,
	[SysKey] [int] NOT NULL,
	[UserKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowversionID] [timestamp] NOT NULL,
	[AttKey] [int] NOT NULL,
 CONSTRAINT [CPK_CRM_AccountEntity] PRIMARY KEY CLUSTERED 
(
	[AddressKey] ASC,
	[APIKey] ASC,
	[CAHKey] ASC,
	[ProfitAmpKey] ASC,
	[ScanTossKey] ASC,
	[SysKey] ASC,
	[UserKey] ASC,
	[AttKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CRM_AccountEntity] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_Address] FOREIGN KEY([AddressKey])
REFERENCES [dbo].[CRM_AccountEntity_Address] ([AddressKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_Address]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_API] FOREIGN KEY([APIKey])
REFERENCES [dbo].[CRM_AccountEntity_API] ([APIKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_API]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_Attestation] FOREIGN KEY([AttKey])
REFERENCES [dbo].[CRM_AccountEntity_Attestation] ([AttKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_Attestation]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_CAH] FOREIGN KEY([CAHKey])
REFERENCES [dbo].[CRM_AccountEntity_CAH] ([CAHKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_CAH]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_ProfitAmp] FOREIGN KEY([ProfitAmpKey])
REFERENCES [dbo].[CRM_AccountEntity_ProfitAmp] ([ProfitAmpKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_ProfitAmp]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_ScanToss] FOREIGN KEY([ScanTossKey])
REFERENCES [dbo].[CRM_AccountEntity_ScanToss] ([ScanTossKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_ScanToss]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_Sys] FOREIGN KEY([SysKey])
REFERENCES [dbo].[CRM_AccountEntity_Sys] ([SysKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_Sys]
GO
ALTER TABLE [dbo].[CRM_AccountEntity]  WITH NOCHECK ADD  CONSTRAINT [FK_CRM_AccountEntity_User] FOREIGN KEY([UserKey])
REFERENCES [dbo].[CRM_AccountEntity_User] ([UserKey])
GO
ALTER TABLE [dbo].[CRM_AccountEntity] CHECK CONSTRAINT [FK_CRM_AccountEntity_User]
GO
