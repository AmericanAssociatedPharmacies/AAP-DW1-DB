USE [SalesDDS]
GO
/****** Object:  Table [dbo].[CAHAccount]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHAccount](
	[PMID] [int] NULL,
	[CAHAccountNo] [nvarchar](250) NULL,
	[AAPEffectiveDate] [date] NULL,
	[AAPQuitDate] [date] NOT NULL,
	[AAPEffectiveDateKey] [int] NULL,
	[AAPQuitDateKey] [int] NULL,
	[CorrectedCAHAccountNo] [nvarchar](250) NULL,
	[AAPAccountNo] [nvarchar](100) NULL,
	[PreviousMemberPMID] [int] NULL
) ON [PRIMARY]
GO
