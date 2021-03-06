USE [ODSIntake]
GO
/****** Object:  Table [Staging].[APIBrandCredits]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APIBrandCredits](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[AcctNumber] [varchar](500) NULL,
	[RxName] [varchar](500) NULL,
	[CredittobeIssued] [varchar](500) NULL,
	[BUSCLS] [varchar](500) NULL,
	[ACHCustomer] [varchar](500) NULL,
	[CustPayTerms] [varchar](500) NULL,
	[TotalBrandPurchases] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APIBrandCredits] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
