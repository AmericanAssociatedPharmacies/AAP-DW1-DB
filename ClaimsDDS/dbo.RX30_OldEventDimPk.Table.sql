USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[RX30_OldEventDimPk]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RX30_OldEventDimPk](
	[OldEventDimPk] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
 CONSTRAINT [CPK_RX30_OldEventDimPk] PRIMARY KEY CLUSTERED 
(
	[OldEventDimPk] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimFact]([DateKey])
) ON [psClaimFact]([DateKey])
GO
