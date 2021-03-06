USE [RXMaster]
GO
/****** Object:  Table [Staging].[API_PMID_Mapping]    Script Date: 12/22/2020 7:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[API_PMID_Mapping](
	[RN] [int] NOT NULL,
	[APIAccountNo] [varchar](15) NOT NULL,
	[PMID] [int] NOT NULL,
	[APIEffectiveDate] [date] NULL,
	[APIQuitDate] [datetime] NULL,
	[APIEffectiveDateKey] [int] NULL,
	[APIQuitDateKey] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_Staging_API_PMID_Mapping] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[API_PMID_Mapping] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
