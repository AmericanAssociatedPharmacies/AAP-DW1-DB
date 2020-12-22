USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[NCPDPStateMedicaidInfo]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NCPDPStateMedicaidInfo](
	[NCPDP] [nvarchar](7) NULL,
	[State Code] [nvarchar](2) NULL,
	[Medicaid ID] [nvarchar](20) NULL,
	[Delete Date] [nvarchar](8) NULL
) ON [PRIMARY]
GO
