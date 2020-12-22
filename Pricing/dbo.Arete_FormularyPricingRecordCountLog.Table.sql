USE [Pricing]
GO
/****** Object:  Table [dbo].[Arete_FormularyPricingRecordCountLog]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Arete_FormularyPricingRecordCountLog](
	[InsertedDate] [datetime] NULL,
	[TotalCount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Arete_FormularyPricingRecordCountLog] ADD  DEFAULT (getdate()) FOR [InsertedDate]
GO
