USE [CAHODS]
GO
/****** Object:  Table [dbo].[CAH_NDC]    Script Date: 12/22/2020 6:50:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAH_NDC](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NDC] [varchar](15) NULL,
	[ITEM_TYPE] [varchar](15) NULL,
	[Type] [varchar](15) NULL,
	[BRAND] [varchar](31) NULL,
	[MaxDateKey] [int] NULL,
	[RowCreatedDate] [datetime] NULL,
 CONSTRAINT [RowID_pk] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAH_NDC] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
