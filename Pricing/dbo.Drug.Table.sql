USE [Pricing]
GO
/****** Object:  Table [dbo].[Drug]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Drug](
	[DrugID] [int] NOT NULL,
	[GenericProductIndicator] [varchar](100) NOT NULL,
	[Form] [varchar](100) NULL,
	[Size] [varchar](25) NULL,
	[Strength] [varchar](250) NULL,
	[Description] [varchar](500) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Drug] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
