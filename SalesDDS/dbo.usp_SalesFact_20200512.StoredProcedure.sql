USE [SalesDDS]
GO
/****** Object:  StoredProcedure [dbo].[usp_SalesFact_20200512]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_SalesFact_20200512]

AS 

SET NOCOUNT ON;

BEGIN


--	TRUNCATE TABLE [Staging].[SalesFact_API]
--	TRUNCATE TABLE Staging.API 
	

--	/*
	
--				Staging.API	
	
--	*/
	
--		/****** Object:  Index [CPK_Staging_API]    Script Date: 5/12/2020 3:27:29 PM ******/
--	ALTER TABLE [Staging].[API] DROP CONSTRAINT [CPK_Staging_API]
	

	
--	/****** Object:  Index [CPK_Staging_API]    Script Date: 5/12/2020 3:27:29 PM ******/
--	ALTER TABLE [Staging].[API] ADD  CONSTRAINT [CPK_Staging_API] PRIMARY KEY CLUSTERED 
--	(
--		[RowID] ASC,
--		[DateKey] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	

--	/*
	
--						Staging.SalesFact_API
	
--	*/


--	/****** Object:  Index [NCI_Staging_SalesFact_API_DateKey]    Script Date: 5/12/2020 12:21:52 PM ******/
--	DROP INDEX [NCI_Staging_SalesFact_API_DateKey] ON [Staging].[SalesFact_API]
	

--	DROP INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [Staging].[SalesFact_API]
	

--	/****** Object:  Index [CPK_Staging_SalesFact_API]    Script Date: 5/12/2020 12:22:29 PM ******/
--	ALTER TABLE [Staging].[SalesFact_API] DROP CONSTRAINT [CPK_Staging_SalesFact_API]
	


--	/****** Object:  Index [CPK_Staging_SalesFact_API]    Script Date: 5/12/2020 12:22:29 PM ******/
--	ALTER TABLE [Staging].[SalesFact_API] ADD  CONSTRAINT [CPK_Staging_SalesFact_API] PRIMARY KEY CLUSTERED 
--	(
--		[PharmacyKey] ASC,
--		[DateKey] ASC,
--		[DrugKey] ASC,
--		[APIEventKey] ASC,
--		[APIEventDateKey] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	


--	/****** Object:  Index [NCI_Staging_SalesFact_API_DateKey]    Script Date: 5/12/2020 12:21:52 PM ******/
--	CREATE NONCLUSTERED INDEX [NCI_Staging_SalesFact_API_DateKey] ON [Staging].[SalesFact_API]
--	(
--		[DateKey] ASC
--	)
--	INCLUDE ( 	[PharmacyKey],
--		[DrugKey],
--		[APIInvoiceQuantity],
--		[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	


--	/****** Object:  Index [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey]    Script Date: 5/12/2020 12:22:06 PM ******/
--	CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [Staging].[SalesFact_API]
--	(
--		[DateKey] ASC,
--		[APIEventKey] ASC,
--		[APIEventDateKey] ASC
--	)
--	INCLUDE ( 	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	

--/***********************************************************************************************************************

--					dbo tables

--*************************************************************************************************************************/


--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_DateKey]
	

--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_DrugKey]
	

--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_EventDimAPI]
	

--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [FK_SalesFact_API_PharmacyKey]
	

--	/****** Object:  Index [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey]    Script Date: 5/12/2020 3:21:46 PM ******/
--	DROP INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [dbo].[SalesFact_API]
	

--	/****** Object:  Index [NCI_SalesFact_API_DateKey]    Script Date: 5/12/2020 3:22:01 PM ******/
--	DROP INDEX [NCI_SalesFact_API_DateKey] ON [dbo].[SalesFact_API]
	

--	/****** Object:  Index [NCC_SalesFact_API]    Script Date: 5/12/2020 3:22:13 PM ******/
--	DROP INDEX [NCC_SalesFact_API] ON [dbo].[SalesFact_API]
	

--	/****** Object:  Index [CPK_SalesFact_API]    Script Date: 5/12/2020 3:22:25 PM ******/
--	ALTER TABLE [dbo].[SalesFact_API] DROP CONSTRAINT [CPK_SalesFact_API]
	


--	/****** Object:  Index [CPK_SalesFact_API]    Script Date: 5/12/2020 3:22:25 PM ******/
--	ALTER TABLE [dbo].[SalesFact_API] ADD  CONSTRAINT [CPK_SalesFact_API] PRIMARY KEY CLUSTERED 
--	(
--		[PharmacyKey] ASC,
--		[DateKey] ASC,
--		[DrugKey] ASC,
--		[APIEventKey] ASC,
--		[APIEventDateKey] ASC
--	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	

--	/****** Object:  Index [NCI_SalesFact_API_DateKey]    Script Date: 5/12/2020 3:22:01 PM ******/
--	CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey] ON [dbo].[SalesFact_API]
--	(
--		[DateKey] ASC
--	)
--	INCLUDE ( 	[PharmacyKey],
--		[DrugKey],
--		[APIInvoiceQuantity],
--		[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	

--	/****** Object:  Index [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey]    Script Date: 5/12/2020 3:21:46 PM ******/
--	CREATE NONCLUSTERED INDEX [NCI_SalesFact_API_DateKey_APIEventKey_APIEventDateKey] ON [dbo].[SalesFact_API]
--	(
--		[DateKey] ASC,
--		[APIEventKey] ASC,
--		[APIEventDateKey] ASC
--	)
--	INCLUDE ( 	[APIExtendedAmount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
--	ON [psSalesFact_RangeLeft](DateKey)
	

--		/****** Object:  Index [NCC_SalesFact_API]    Script Date: 5/12/2020 3:22:13 PM ******/
--	CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_SalesFact_API] ON [dbo].[SalesFact_API]
--	(
--		[PharmacyKey],
--		[DateKey],
--		[DrugKey],
--		[APIEventKey],
--		[APIEventDateKey],
--		[APIInvoiceQuantity],
--		[APIUnitAmount],
--		[APILineItemAmount],
--		[APIExtendedAmount],
--		[TransactionCount]
--	)WITH (DROP_EXISTING = OFF)
--	ON [psSalesFact_RangeLeft](DateKey)
	

	/*
	
					dbo.EventDimAPI
	
	*/

	--/****** Object:  Index [NCC_EventDimAPI]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [NCC_EventDimAPI] ON [dbo].[EventDimAPI]
	
	--/****** Object:  Index [NCI_EventDimAPI_RowversionID_2]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [NCI_EventDimAPI_RowversionID_2] ON [dbo].[EventDimAPI]
	
	--/****** Object:  Index [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
	
	--/****** Object:  Index [NCI_EventDim_RowversionID]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [NCI_EventDim_RowversionID] ON [dbo].[EventDimAPI]
	
	--/****** Object:  Index [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
	
	--/****** Object:  Index [IX_EventDimAPI_RowVersionID_DateKey]    Script Date: 5/12/2020 3:30:09 PM ******/
	--DROP INDEX [IX_EventDimAPI_RowVersionID_DateKey] ON [dbo].[EventDimAPI]
	
	/****** Object:  Index [CPK_API_EventDim]    Script Date: 5/12/2020 4:06:37 PM ******/
	--ALTER TABLE [dbo].[EventDimAPI] DROP CONSTRAINT [CPK_API_EventDim]

	/****** Object:  Index [CPK_API_EventDim]    Script Date: 5/12/2020 7:39:25 PM ******/
	ALTER TABLE [dbo].[EventDimAPI] ADD  CONSTRAINT [CPK_API_EventDim] PRIMARY KEY CLUSTERED 
	(
		[EventKey] ASC,
		[DateKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
	ON [psSalesFact_RangeLeft](DateKey)
	
	

	/****** Object:  Index [IX_EventDimAPI_RowVersionID_DateKey]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE UNIQUE NONCLUSTERED INDEX [IX_EventDimAPI_RowVersionID_DateKey] ON [dbo].[EventDimAPI]
	(
		[RowversionID] ASC,
		[DateKey] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [psSalesFact_RangeLeft](DateKey)

	
	SET ANSI_PADDING ON

	
	/****** Object:  Index [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE NONCLUSTERED INDEX [NCI_EventDim_IsCredit_Type_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
	(
		[IsCredit] ASC,
		[Type] ASC,
		[IsOrderFee] ASC,
		[IsSourceDelete] ASC
	)
	INCLUDE ( 	[EventKey],
		[DateKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [psSalesFact_RangeLeft](DateKey)
	
	SET ANSI_PADDING ON

	
	/****** Object:  Index [NCI_EventDim_RowversionID]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE NONCLUSTERED INDEX [NCI_EventDim_RowversionID] ON [dbo].[EventDimAPI]
	(
		[RowversionID] ASC,
		[DateKey] ASC
	)
	INCLUDE ( 	[EventKey],
		[PMID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [psSalesFact_RangeLeft](DateKey)
	
	SET ANSI_PADDING ON

	
	/****** Object:  Index [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE NONCLUSTERED INDEX [NCI_EventDimAPI_IsCredit_IsOrderFee_IsSourceDelete] ON [dbo].[EventDimAPI]
	(
		[IsCredit] ASC,
		[IsOrderFee] ASC,
		[IsSourceDelete] ASC
	)
	INCLUDE ( 	[EventKey],
		[DateKey],
		[InvoiceDate],
		[Type]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [psSalesFact_RangeLeft](DateKey)
	
	SET ANSI_PADDING ON

	
	/****** Object:  Index [NCI_EventDimAPI_RowversionID_2]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE NONCLUSTERED INDEX [NCI_EventDimAPI_RowversionID_2] ON [dbo].[EventDimAPI]
	(
		[RowversionID] ASC
	)
	INCLUDE ( 	[EventKey],
		[PMID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) 
	ON [psSalesFact_RangeLeft](DateKey)
	
	SET ANSI_PADDING ON

	
	/****** Object:  Index [NCC_EventDimAPI]    Script Date: 5/12/2020 3:30:10 PM ******/
	CREATE NONCLUSTERED COLUMNSTORE INDEX [NCC_EventDimAPI] ON [dbo].[EventDimAPI]
	(
		[EventKey],
		[DateKey],
		[InvoiceNumber],
		[InvoiceLineNumber],
		[InvoiceDate],
		[TerritoryManagerNumber],
		[AccountNumber],
		[CustomerReference],
		[PMID],
		[WharehouseNumber],
		[ItemGroupNumber],
		[AccountGroupNumber],
		[NDCOriginal],
		[NDC],
		[ItemNumber],
		[RowversionID],
		[RowCreatedDate],
		[IsCredit],
		[Type],
		[IsOrderFee],
		[ItemDescription],
		[APISalesDetailID],
		[IsSourceDelete]
	)WITH (DROP_EXISTING = OFF) 
	ON [psSalesFact_RangeLeft](DateKey)
	


	/*

				Recreate FK's for SalesFact_API
	
	*/

	ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_DateKey] FOREIGN KEY([DateKey])
	REFERENCES [dbo].[DateDim] ([DateKey])
	

	ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_DrugKey] FOREIGN KEY([DrugKey])
	REFERENCES [dbo].[DrugDim] ([DrugKey])
	

	ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_EventDimAPI] FOREIGN KEY([APIEventKey], [DateKey])
	REFERENCES [dbo].[EventDimAPI] ([EventKey], [DateKey])
	

	ALTER TABLE [dbo].[SalesFact_API]  WITH NOCHECK ADD  CONSTRAINT [FK_SalesFact_API_PharmacyKey] FOREIGN KEY([PharmacyKey])
	REFERENCES [dbo].[PharmacyDim] ([PharmacyKey])


END
	
GO
