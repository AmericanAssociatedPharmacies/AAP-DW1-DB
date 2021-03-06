USE [WebDev]
GO
/****** Object:  Table [dbo].[rform_claims_research]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rform_claims_research](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[BIN] [nvarchar](10) NULL,
	[PCN] [nvarchar](50) NULL,
	[Group] [nvarchar](50) NULL,
	[PatName] [nvarchar](100) NULL,
	[PatID] [nvarchar](50) NULL,
	[PatDOB] [smalldatetime] NULL,
	[Wholesaler] [nvarchar](100) NULL,
	[NDC] [nvarchar](11) NULL,
	[FillDate] [smalldatetime] NULL,
	[Quantity] [int] NULL,
	[RxNbr] [nvarchar](20) NULL,
	[DaySupply] [nvarchar](20) NULL,
	[TotalCost] [float] NULL,
	[TotalPaid] [float] NULL,
	[Maced] [bit] NULL,
	[NCPDP] [nvarchar](20) NULL,
	[ContactName] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[Phone] [nvarchar](20) NULL,
	[Fax] [nvarchar](20) NULL,
	[SendPBM] [int] NULL,
	[Notes] [text] NULL,
	[CreatedOn] [smalldatetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[DispensingFee] [float] NULL,
	[Compound] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
