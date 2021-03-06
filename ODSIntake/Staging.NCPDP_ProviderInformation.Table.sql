USE [ODSIntake]
GO
/****** Object:  Table [Staging].[NCPDP_ProviderInformation]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[NCPDP_ProviderInformation](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[C1] [varchar](8000) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[NCPDP_ProviderInformation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
