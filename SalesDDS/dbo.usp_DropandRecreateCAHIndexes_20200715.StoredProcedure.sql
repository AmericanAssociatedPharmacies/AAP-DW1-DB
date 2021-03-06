USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_DropandRecreateCAHIndexes_20200715]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_DropandRecreateCAHIndexes_20200715]

AS

BEGIN

/**********************************************************************************************************************
														DROP INDEX
***********************************************************************************************************************/


--ALTER TABLE [Staging].[EventDimCAH] DROP CONSTRAINT [CPK_Staging_EventDimCAH]


--DROP INDEX [NCI_Staging_CAH_DateKey] ON [Staging].[CAH]

--ALTER TABLE [Staging].[CAH] DROP CONSTRAINT [PK_Staging_CHPH_AAP]


--DROP INDEX [NCI_SalesFact_CAH_DateKey_DrugKey] ON [dbo].[SalesFact_CAH]

--DROP INDEX [NCI_SalesFact_CAH_CAHEventKey_CAHEventDateKey] ON [dbo].[SalesFact_CAH]

--DROP INDEX [NCI_[SalesFact_CAH_CAHEventKey_CAHEventDateKey] ON [dbo].[SalesFact_CAH]

--DROP INDEX [NCC_SalesFact_CAH] ON [dbo].[SalesFact_CAH]

--DROP INDEX [NCI_SalesFact_CAH_PharmacyKey] ON [dbo].[SalesFact_CAH]

--ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [CPK_SalesFact_CAH_2]

--ALTER TABLE [dbo].[SalesFact_CAH] DROP CONSTRAINT [FK_SalesFact_CAH_EventDimCAH]



--DROP INDEX [NCC_SalesFact_CAH] ON [Staging].[SalesFact_CAH]

--DROP INDEX [NCI_SalesFact_CAH_PharmacyKey] ON [Staging].[SalesFact_CAH]

--ALTER TABLE [Staging].[SalesFact_CAH] DROP CONSTRAINT [CPK_SalesFact_CAH]


--DROP INDEX [NCI_EventDimCAH_DateKey_CHPH_AAP_ID] ON [dbo].[EventDimCAH]

--DROP INDEX [NCI_EventDimCAH_DateKey] ON [dbo].[EventDimCAH]

--DROP INDEX [NCC_EventDimCAH] ON [dbo].[EventDimCAH]

--DROP INDEX [NCI_EventDimCAH_DateKey_RowversionID] ON [dbo].[EventDimCAH]

--ALTER TABLE [dbo].[EventDimCAH] DROP CONSTRAINT [CPK_CAH_EventDim_2]






/**************************************************************************************************************************
														CREATE INDEX
***************************************************************************************************************************/



--Staging.CAH
ALTER TABLE [Staging].[CAH] ADD CONSTRAINT [PK_Staging_CHPH_AAP] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_Staging_CAH_DateKey] ON [Staging].[CAH]
(
	[DateKey] ASC
)
INCLUDE ( 	[PMID],
	[NDC],
	[SHIP_QTY],
	[UNIT_COST],
	[EXT_COST],
	[CORP_AWP],
	[WAC],
	[RowversionID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)





--dbo.SalesFact_CAH
ALTER TABLE [dbo].[SalesFact_CAH] ADD  CONSTRAINT [CPK_SalesFact_CAH_2] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[CAHEventKey] ASC,
	[CAHEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_SalesFact_CAH_DateKey_DrugKey] ON [dbo].[SalesFact_CAH]
(
	[DateKey] ASC,
	[DrugKey] ASC
)
INCLUDE ( 	[CAHExtendedSales]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)



CREATE NONCLUSTERED INDEX [NCI_SalesFact_CAH_CAHEventKey_CAHEventDateKey] ON [dbo].[SalesFact_CAH]
(
	[CAHEventKey] ASC,
	[CAHEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_SalesFact_CAH] ON [dbo].[SalesFact_CAH]
(
	[PharmacyKey],
	[DateKey],
	[DrugKey],
	[CAHEventKey],
	[CAHEventDateKey],
	[CAHInvoiceQuantity],
	[CAHUnitAmount],
	[CAHExtendedSales],
	[CAH_AWP],
	[CAH_WAC],
	[TransactionCount],
	[PurchaseAtIP],
	[GenericPurchaseAtIP],
	[BrandPurchaseAtIP],
	[PurchaseQty],
	[GenericPurchaseQty],
	[BrandPurchaseQty],
	[InvoicePerDose],
	[GenericInvoicePerDose],
	[BrandInvoicePerDose],
	[Doses],
	[GenericDoses],
	[BrandDoses]
)WITH (DROP_EXISTING = OFF)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_SalesFact_CAH_PharmacyKey] ON [dbo].[SalesFact_CAH]
(
	[PharmacyKey] ASC
)
INCLUDE ( 	[DateKey],
	[DrugKey],
	[CAHInvoiceQuantity]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


--Staging.SalesFact_CAH
ALTER TABLE [Staging].[SalesFact_CAH] ADD  CONSTRAINT [CPK_SalesFact_CAH] PRIMARY KEY CLUSTERED 
(
	[PharmacyKey] ASC,
	[DateKey] ASC,
	[DrugKey] ASC,
	[CAHEventKey] ASC,
	[CAHEventDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_SalesFact_CAH] ON [Staging].[SalesFact_CAH]
(
	[PharmacyKey],
	[DateKey],
	[DrugKey],
	[CAHEventKey],
	[CAHEventDateKey],
	[CAHInvoiceQuantity],
	[CAHUnitAmount],
	[CAHExtendedSales],
	[CAH_AWP],
	[CAH_WAC],
	[TransactionCount]
)WITH (DROP_EXISTING = OFF)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_SalesFact_CAH_PharmacyKey] ON [Staging].[SalesFact_CAH]
(
	[PharmacyKey] ASC
)
INCLUDE ( 	[DateKey],
	[DrugKey],
	[CAHInvoiceQuantity]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

--Staging.EventDim_CAH
ALTER TABLE [Staging].[EventDimCAH] ADD  CONSTRAINT [CPK_Staging_EventDimCAH] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)


--dbo.EventDimCAH
--ALTER TABLE [dbo].[EventDimCAH] ADD  CONSTRAINT [CPK_CAH_EventDim_2] PRIMARY KEY CLUSTERED 
--(
--	[EventKey] ASC,
--	[DateKey] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_EventDimCAH_DateKey_CHPH_AAP_ID] ON [dbo].[EventDimCAH]
(
	[DateKey] ASC,
	[CHPH_AAP_ID] ASC
)
INCLUDE ( 	[EventKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_EventDimCAH_DateKey] ON [dbo].[EventDimCAH]
(
	[DateKey] ASC
)
INCLUDE ( 	[EventKey],
	[PMID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_EventDimCAH] ON [dbo].[EventDimCAH]
(
	[EventKey],
	[DateKey],
	[InvoiceNumber],
	[InvoiceLineNumber],
	[InvoiceDate],
	[PMID],
	[DistributionCenter],
	[NDC],
	[UPC],
	[ItemNumber],
	[ItemDescription],
	[ItemType],
	[OrderNumber],
	[IsBackupSource],
	[IsTenSource],
	[IsSourceWeekly],
	[IsTopGenerics],
	[RowversionID],
	[RowCreatedDate],
	[CHPH_AAP_ID],
	[RowversionID_DB1],
	[CAHAccountNo],
	[AccountName],
	[CAHType],
	[Brand]
)WITH (DROP_EXISTING = OFF)
ON [psSalesFact_RangeLeft](DateKey)

CREATE NONCLUSTERED INDEX [NCI_EventDimCAH_DateKey_RowversionID] ON [dbo].[EventDimCAH]
(
	[DateKey] ASC,
	[RowversionID] ASC
)
INCLUDE ( 	[EventKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
ON [psSalesFact_RangeLeft](DateKey)

ALTER TABLE [dbo].[SalesFact_CAH]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_CAH_EventDimCAH] FOREIGN KEY([CAHEventKey], [CAHEventDateKey])
REFERENCES [dbo].[EventDimCAH] ([EventKey], [DateKey])




END
GO
