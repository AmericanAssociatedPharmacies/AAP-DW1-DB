USE [Pricing]
GO
/****** Object:  Table [dbo].[NADAC_Error]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NADAC_Error](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[NADACPerUnit] [varchar](500) NULL,
	[C1] [int] NOT NULL
) ON [PRIMARY]
GO
