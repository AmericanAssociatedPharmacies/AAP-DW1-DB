USE [ODSIntake]
GO
/****** Object:  Table [Archive].[PM_Rebates_PPartner_New]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[PM_Rebates_PPartner_New](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Period] [varchar](50) NULL,
	[PMID] [float] NULL,
	[VolumeAmt] [float] NULL,
	[RebateAmt] [float] NULL,
	[PaymentAmt] [float] NULL,
	[Eligible] [nvarchar](255) NULL,
	[Affiliate] [nvarchar](255) NULL,
	[LastPayment] [nvarchar](255) NULL,
	[Paid To Store] [float] NULL,
	[Paid To Affiliate] [float] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [varbinary](8) NOT NULL,
 CONSTRAINT [CPK_Archive_PM_Rebates_PPartner_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Archive].[PM_Rebates_PPartner_New] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
