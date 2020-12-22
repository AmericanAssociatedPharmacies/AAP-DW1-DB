USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[RX30_DatesToLoad]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[RX30_DatesToLoad](
	[RN] [int] NOT NULL,
	[DateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[RX30_DatesToLoad] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
