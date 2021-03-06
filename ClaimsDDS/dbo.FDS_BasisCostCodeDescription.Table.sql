USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDS_BasisCostCodeDescription]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDS_BasisCostCodeDescription](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](2) NULL,
	[Description] [varchar](255) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FDS_BasisCostCodeDescription] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
