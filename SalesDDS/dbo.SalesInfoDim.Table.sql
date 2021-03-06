USE [SalesDDS]
GO
/****** Object:  Table [dbo].[SalesInfoDim]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesInfoDim](
	[SalesInfoKey] [int] IDENTITY(1,1) NOT NULL,
	[IsSourceWeekly] [bit] NOT NULL,
	[IsTenSourceGeneric] [bit] NOT NULL,
	[IsTopGenerics] [bit] NOT NULL,
	[IsBackupSource] [bit] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_SalesInfoDim] PRIMARY KEY CLUSTERED 
(
	[SalesInfoKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SalesInfoDim] ADD  DEFAULT ((0)) FOR [IsSourceWeekly]
GO
ALTER TABLE [dbo].[SalesInfoDim] ADD  DEFAULT ((0)) FOR [IsTenSourceGeneric]
GO
ALTER TABLE [dbo].[SalesInfoDim] ADD  DEFAULT ((0)) FOR [IsTopGenerics]
GO
ALTER TABLE [dbo].[SalesInfoDim] ADD  DEFAULT ((0)) FOR [IsBackupSource]
GO
ALTER TABLE [dbo].[SalesInfoDim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
