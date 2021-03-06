USE [PharmacyMaster]
GO
/****** Object:  Table [Staging].[pm_rebates_highvolume_New]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[pm_rebates_highvolume_New](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NULL,
	[rebate_type] [varchar](31) NULL,
	[PMID] [nvarchar](255) NULL,
	[AAP#] [nvarchar](255) NULL,
	[API acct] [nvarchar](255) NULL,
	[Customer Name] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[ST] [nvarchar](255) NULL,
	[Bs Class] [nvarchar](255) NULL,
	[Month] [nvarchar](255) NULL,
	[Current Est Mo Sales] [money] NULL,
	[Mo API Volume] [money] NULL,
	[CAH off Contract-LTC Volume] [money] NULL,
	[AAP Net Sales] [money] NULL,
	[Mo Comb Volume] [money] NULL,
	[AAP Sales- COG Applied] [money] NULL,
	[AAP Brand RX Sales] [money] NULL,
	[Current CA COG] [float] NULL,
	[Base] [float] NULL,
	[Brand RX@WAC] [money] NULL,
	[Brand RX Saved] [money] NULL,
	[High Volume Incentive] [money] NULL,
	[Total Saved] [money] NULL,
	[ECOG] [float] NULL,
	[COG Reduction] [float] NULL,
	[Generic Source] [money] NULL,
	[1% Generic Admin] [money] NULL,
	[Incentive from AAP Net Sales] [money] NULL,
	[A/P Payment Mode] [nvarchar](255) NULL,
	[Group] [nvarchar](255) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [varbinary](8) NOT NULL,
 CONSTRAINT [CPK_Staging_pm_rebates_highvolume_New] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
