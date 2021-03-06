USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPRemitAndReconciliationInformation]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPRemitAndReconciliationInformation](
	[Remit and Reconciliation ID] [nvarchar](6) NULL,
	[Remit and Reconciliation Name] [nvarchar](35) NULL,
	[Remit and Reconciliation Address 1] [nvarchar](55) NULL,
	[Remit and Reconciliation Address 2] [nvarchar](55) NULL,
	[Remit and Reconciliation City] [nvarchar](30) NULL,
	[Remit and Reconciliation State Code] [nvarchar](2) NULL,
	[Remit and Reconciliation Zip Code] [nvarchar](9) NULL,
	[Remit and Reconciliation Phone Number] [nvarchar](10) NULL,
	[Remit and Reconciliation Extension] [nvarchar](5) NULL,
	[Remit and Reconciliation FAX Number] [nvarchar](10) NULL,
	[Remit and Reconciliation NPI] [nvarchar](10) NULL,
	[Remit and Reconciliation Federal Tax ID] [nvarchar](15) NULL,
	[Remit and Reconciliation Contact Name] [nvarchar](30) NULL,
	[Remit and Reconciliation Contact Title] [nvarchar](30) NULL,
	[Remit and Reconciliation Contact E-mail Address] [nvarchar](50) NULL,
	[Delete Date] [nvarchar](8) NULL,
	[Filler] [nvarchar](140) NULL
) ON [PRIMARY]
GO
