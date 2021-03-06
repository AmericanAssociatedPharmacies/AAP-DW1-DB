USE [Pricing]
GO
/****** Object:  Table [dbo].[Competitor]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Competitor](
	[CompetitorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[IsVendor] [char](1) NOT NULL,
	[IsFirstClass] [bit] NOT NULL,
	[IsSecondClass] [bit] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Competitor_CompetitorID] PRIMARY KEY CLUSTERED 
(
	[CompetitorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Competitor] ADD  DEFAULT ('N') FOR [IsVendor]
GO
ALTER TABLE [dbo].[Competitor] ADD  DEFAULT ((0)) FOR [IsFirstClass]
GO
ALTER TABLE [dbo].[Competitor] ADD  DEFAULT ((0)) FOR [IsSecondClass]
GO
ALTER TABLE [dbo].[Competitor] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
