USE [Medispan]
GO
/****** Object:  Table [dbo].[DrugMaster_2_20171208]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DrugMaster_2_20171208](
	[NDC] [varchar](11) NOT NULL,
	[GPI] [varchar](14) NULL,
	[DrugName] [varchar](25) NULL,
	[MFG] [varchar](30) NULL,
	[DrugType] [varchar](50) NULL,
	[DrugTypeShort] [varchar](3) NULL,
	[Unit] [varchar](2) NULL,
	[Form] [varchar](4) NULL,
	[PS] [numeric](8, 3) NULL,
	[PD] [varchar](10) NULL,
	[RxOTC] [varchar](3) NULL,
	[Repack] [varchar](1) NULL,
	[GPIDesc] [varchar](60) NULL,
	[Strength] [varchar](25) NULL,
	[Strength_Unit_Measure] [varchar](11) NULL,
	[OBSDTEC] [smalldatetime] NULL,
	[DEA] [int] NOT NULL,
	[WACPkg] [numeric](10, 2) NULL,
	[WAC] [numeric](13, 5) NULL,
	[WACEffDate] [smalldatetime] NULL,
	[AWPPkg] [numeric](10, 2) NULL,
	[AWP] [numeric](13, 5) NULL,
	[BBDC] [smalldatetime] NULL,
	[MSC] [varchar](1) NULL,
	[BNC] [varchar](1) NULL,
	[CSP] [numeric](37, 0) NULL,
	[DESI] [varchar](1) NULL,
	[DEA_Class_Code] [varchar](5) NULL,
	[RouteAdmin] [varchar](2) NULL,
	[RX_OTC_Indicator_Code] [varchar](1) NULL,
	[Unit_Dose_Unit_of_Use_Package] [varchar](1) NULL,
	[AHFSCC_Therapeutic_Class_Code] [numeric](37, 0) NULL,
	[GPPC] [varchar](25) NULL
) ON [PRIMARY]
GO
