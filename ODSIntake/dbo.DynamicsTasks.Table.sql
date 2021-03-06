USE [ODSIntake]
GO
/****** Object:  Table [dbo].[DynamicsTasks]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DynamicsTasks](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](200) NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[RegardingObjectID] [uniqueidentifier] NULL,
	[Description] [text] NULL,
	[OwnerID] [uniqueidentifier] NULL,
	[OwnerIDType] [varchar](25) NULL,
	[regardingobjecttypecode] [nvarchar](64) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[DynamicsTasks] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
