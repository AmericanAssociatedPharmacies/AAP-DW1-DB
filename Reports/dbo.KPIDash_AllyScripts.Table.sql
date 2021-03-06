USE [Reports]
GO
/****** Object:  Table [dbo].[KPIDash_AllyScripts]    Script Date: 12/22/2020 7:39:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KPIDash_AllyScripts](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](255) NULL,
	[State] [char](2) NULL,
	[AAPAccountNumber] [varchar](255) NULL,
	[APIAccountNumber] [varchar](255) NULL,
	[Date] [datetime] NULL,
	[RxReceived] [int] NULL,
	[RxFilled] [int] NULL,
	[RxTransferred] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[KPIDash_AllyScripts] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
