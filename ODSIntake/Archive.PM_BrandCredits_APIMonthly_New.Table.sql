USE [ODSIntake]
GO
/****** Object:  Table [Archive].[PM_BrandCredits_APIMonthly_New]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[PM_BrandCredits_APIMonthly_New](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [varchar](10) NULL,
	[PMID] [varchar](50) NULL,
	[APIAccountNo] [varchar](255) NULL,
	[AccountName] [varchar](255) NULL,
	[BrandCredits] [money] NULL,
	[Territory] [varchar](255) NULL,
	[BrandSales] [money] NULL,
	[ACH] [bit] NULL,
	[PayTerms] [varchar](255) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [varbinary](8) NOT NULL,
 CONSTRAINT [CPK_Archive_PM_BrandCredits_APIMonthly_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[PM_BrandCredits_APIMonthly_New] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
