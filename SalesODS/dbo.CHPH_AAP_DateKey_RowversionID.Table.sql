USE [SalesODS]
GO
/****** Object:  Table [dbo].[CHPH_AAP_DateKey_RowversionID]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CHPH_AAP_DateKey_RowversionID](
	[RN] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[MaxRowversionID] [varbinary](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CHPH_AAP_DateKey_RowversionID] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
