USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDSComplianceReportDatesToLoad]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDSComplianceReportDatesToLoad](
	[RN] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FDSComplianceReportDatesToLoad] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
