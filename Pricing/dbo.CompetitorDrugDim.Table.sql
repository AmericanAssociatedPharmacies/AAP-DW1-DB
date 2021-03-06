USE [Pricing]
GO
/****** Object:  Table [dbo].[CompetitorDrugDim]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompetitorDrugDim](
	[CompetitorDrugKey] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[NDC] [varchar](12) NOT NULL,
	[API_ItemNumber] [varchar](25) NULL,
	[API_NDC] [varchar](25) NULL,
	[ABCItemNumber] [varchar](25) NULL,
	[ABC_NDC] [varchar](25) NULL,
	[CAHItemNumber] [varchar](25) NULL,
	[CAH_NDC] [varchar](25) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[CAH_RowVersionID] [varbinary](8) NULL,
	[API_RowVersionID] [varbinary](8) NULL,
	[ABC_RowVersionID] [varbinary](8) NULL,
	[CAHContractType] [varchar](50) NULL,
	[RowUpdatedDate] [datetime] NULL,
	[McKesson_NDC] [varchar](25) NULL,
	[McKessonItemNumber] [varchar](25) NULL,
	[McKessonRowversionID] [varbinary](8) NULL,
 CONSTRAINT [CPK_CompetitorDrugDim] PRIMARY KEY CLUSTERED 
(
	[CompetitorDrugKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CompetitorDrugDim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
