USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CardinalComplete]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CardinalComplete](
	[RowID] [int] NOT NULL,
	[DateKey] [int] NULL,
	[UNITPRODUCT] [varchar](500) NULL,
	[SCANNEDUNITPRODUCTCODE] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[CARDINALITEMNUMBER] [varchar](500) NULL,
	[RXOTCFLAG] [varchar](500) NULL,
	[BRANDNAME] [varchar](500) NULL,
	[GENERICPRODUCTDESCRIPTION] [varchar](500) NULL,
	[AWP] [varchar](500) NULL,
	[CONTRACTPRICE] [varchar](500) NULL,
	[INVOICEPRICE] [varchar](500) NULL,
	[BASEPRICE] [varchar](500) NULL,
	[RETAILPRICE] [varchar](500) NULL,
	[FORM] [varchar](500) NULL,
	[STRENGTH] [varchar](500) NULL,
	[SIZE] [varchar](500) NULL,
	[UNITOFMEASURE] [varchar](500) NULL,
	[VENDORNAME] [varchar](500) NULL,
	[ACCUNETSIZE] [varchar](500) NULL,
	[CASEQUANTITY] [varchar](500) NULL,
	[PACKQUANTITY] [varchar](500) NULL,
	[UNITSIZE] [varchar](500) NULL,
	[DISPENSEQUANTITY] [varchar](500) NULL,
	[THERAPEUTICCLASSCODE] [varchar](500) NULL,
	[CONTRACTNUMBER] [varchar](500) NULL,
	[CONTRACTNAME] [varchar](500) NULL,
	[CONTRACTSTARTDATE] [varchar](500) NULL,
	[CONTRACTENDDATE] [varchar](500) NULL,
	[INVOICEPRICECHANGEDATE] [varchar](500) NULL,
	[BASEPRICECHANGEDATE] [varchar](500) NULL,
	[FINELINECODE] [varchar](500) NULL,
	[PREVIOUSINVOICEPRICE] [varchar](500) NULL,
	[CCAHEADER] [varchar](500) NULL,
	[GENERICCODE] [varchar](500) NULL,
	[GPPCCODE] [varchar](500) NULL,
	[GPI] [varchar](500) NULL,
	[API_Size] [varchar](500) NULL,
	[API ITEM] [varchar](500) NULL,
	[API PRICE] [varchar](500) NULL,
	[Adj Rebate] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
