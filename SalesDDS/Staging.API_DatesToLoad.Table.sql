USE [SalesDDS]
GO
/****** Object:  Table [Staging].[API_DatesToLoad]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[API_DatesToLoad](
	[RN] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[API_DatesToLoad] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
