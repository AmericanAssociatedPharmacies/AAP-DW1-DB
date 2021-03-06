USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_APIOrder_Load]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[usp_APIOrder_Load]
AS
SET NOCOUNT ON;

INSERT INTO API.[dbo].[APIOrder] ([OrderNumber], [API_Item_Number], [Quantity], [OrderDate], [ItemDesc], [RowversionID])
SELECT [OrderNumber], [API_Item_Number], [Quantity], [OrderDate], [ItemDesc], [RowversionID]
FROM API.[Staging].[APIOrder]
GO
