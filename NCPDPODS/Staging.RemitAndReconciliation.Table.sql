USE [NCPDPODS]
GO
/****** Object:  Table [Staging].[RemitAndReconciliation]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[RemitAndReconciliation](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RemitAndReconciliationID] [varchar](6) NULL,
	[RemitAndReconciliationName] [varchar](35) NULL,
	[RemitAndReconciliationAddress1] [varchar](55) NULL,
	[RemitAndReconciliationAddress2] [varchar](55) NULL,
	[RemitAndReconciliationCity] [varchar](30) NULL,
	[RemitAndReconciliationStateCode] [varchar](2) NULL,
	[RemitAndReconciliationZipCode] [varchar](9) NULL,
	[RemitAndReconciliationPhoneNumber] [varchar](10) NULL,
	[RemitAndReconciliationExtension] [varchar](5) NULL,
	[RemitAndReconciliationFAXNumber] [varchar](10) NULL,
	[RemitAndReconciliationNPI] [varchar](10) NULL,
	[RemitAndReconciliationFederalTaxID] [varchar](15) NULL,
	[RemitAndReconciliationContactName] [varchar](30) NULL,
	[RemitAndReconciliationContactTitle] [varchar](30) NULL,
	[RemitAndReconciliationEmailAddress] [varchar](50) NULL,
	[RemitAndReconciliationDeleteDate] [varchar](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_RemitAndReconciliation] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[RemitAndReconciliation] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
