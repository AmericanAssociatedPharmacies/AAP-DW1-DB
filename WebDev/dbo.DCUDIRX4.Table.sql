USE [WebDev]
GO
/****** Object:  Table [dbo].[DCUDIRX4]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DCUDIRX4](
	[NDC] [varchar](11) NULL,
	[AWP] [numeric](13, 5) NULL,
	[DrugName] [varchar](25) NULL,
	[Reimbursement Indictor] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
