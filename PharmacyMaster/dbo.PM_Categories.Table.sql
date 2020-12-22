USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Categories]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Categories](
	[ID] [int] NOT NULL,
	[Description] [varchar](70) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
