USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDSComplianceReport]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDSComplianceReport](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[QuantityDispensed] [numeric](38, 3) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsGeneric] [bit] NULL,
	[PrescriptionNumber] [varchar](100) NULL,
	[RefillNumber] [int] NULL,
	[TransactionDate] [date] NULL,
	[NDC] [varchar](100) NULL,
	[Is340BClaim] [bit] NULL,
	[ItemCode] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimsFact_RangeLeft]([DateKey])
) ON [psClaimsFact_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[FDSComplianceReport] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[FDSComplianceReport] ADD  DEFAULT ((0)) FOR [ItemCode]
GO
