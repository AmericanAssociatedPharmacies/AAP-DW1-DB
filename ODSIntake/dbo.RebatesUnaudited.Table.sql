USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RebatesUnaudited]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RebatesUnaudited](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[RebateDate] [datetime] NOT NULL,
	[APIBrandRx] [money] NOT NULL,
	[APIGenericRx] [money] NOT NULL,
	[APIOTC] [money] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_RebatesUnaudited] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [AK_RebatesUnaudited] UNIQUE NONCLUSTERED 
(
	[PMID] ASC,
	[RebateDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RebatesUnaudited] ADD  DEFAULT ((0.00)) FOR [RebateDate]
GO
ALTER TABLE [dbo].[RebatesUnaudited] ADD  DEFAULT ((0.00)) FOR [APIBrandRx]
GO
ALTER TABLE [dbo].[RebatesUnaudited] ADD  DEFAULT ((0.00)) FOR [APIGenericRx]
GO
ALTER TABLE [dbo].[RebatesUnaudited] ADD  DEFAULT ((0.00)) FOR [APIOTC]
GO
ALTER TABLE [dbo].[RebatesUnaudited] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
