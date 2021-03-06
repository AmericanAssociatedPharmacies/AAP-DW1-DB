USE [API]
GO
/****** Object:  StoredProcedure [dbo].[usp_Arete_APIInvoiceData]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE PROC [dbo].[usp_Arete_APIInvoiceData]

AS

SET NOCOUNT ON;

TRUNCATE TABLE API.dbo.AreteRecordCountLog

DECLARE @Date DateTime
DECLARE @TotalRecords Int

IF DATENAME(DW, GETDATE()) = 'MONDAY'
SET  @Date = DATEADD(Day, DATEDIFF(Day, 0, getdate())-3, 0)

IF DATENAME(DW, GETDATE()) IN('TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY')
SET @Date = DATEADD(Day, DATEDIFF(Day, 0, getdate())-1, 0)


SELECT dt.Customer_Name, dt.Customer_No, dt.Item_No, dt.NDC, dt.Item_Type, dt.Item_Descr, dt.Generic_Name
	  ,dt.Trade_Name, dt.Inv_Date, dt.Invoice_No, dt.PurchasesType, dt.Order_Qty, dt.Ship_Qty, dt.Unit_Cost
	  ,dt.Ext_Cost, dt.WAC, dt.MFG, dt.Strength, dt.CarrierDesc, dt.NCPDP, dt.EnteredBy
FROM(SELECT DISTINCT S.id
			,S.[CustomerName] AS Customer_Name
			,S.[WHAccountID] AS Customer_No
			,S.[APIItemNbr] AS Item_No
			,S.[NDC]
			,S.[Type] AS Item_Type
			,S.[ItemDescription] AS Item_Descr
			,NULL Generic_Name
			,NULL AS Trade_Name
			,S.[InvDate] AS Inv_Date
			,S.[InvNbr] AS Invoice_No
			,NULL AS PurchasesType
			,B.Quantity AS Order_Qty
			,S.[Qty] AS Ship_Qty
			,S.[UnitAmount] AS Unit_Cost
			,S.[ExtSales] AS Ext_Cost
			,D.WAC
			,D.MFG
			,D.Strength
			,A.CarrierDesc 
			,U.new_ncpdp AS NCPDP 
			,S.Territory AS EnteredBy
	FROM [API].[dbo].[APISalesDetail] AS S 
		 INNER JOIN [API].dbo.Order_SalesDetal_XRef AS x ON S.ID = X.SalesDetailID
		 INNER JOIN [API].[dbo].[APIOrder] AS B ON B.RowID = X.OrderID
		 LEFT JOIN Medispan.dbo.DrugMaster AS D ON S.NDC = D.NDC
		 LEFT JOIN API.dbo.APISalesInvoice_Web AS A ON S.WHAccountID = A.WHAccountID 
		                                               AND S.OrderNbr = A.OrderNbr
		 LEFT JOIN DynamicsODS.dbo.CRM_AccountEntity_API AS C ON S.WHAccountID = C.new_api_account
		 LEFT JOIN DynamicsODS.dbo.CRM_AccountEntity_User AS U ON C.accountid = U.accountid
		WHERE S.InvDate = @Date
	    ) AS dt

SET @TotalRecords = @@ROWCOUNT
INSERT INTO API.dbo.AreteRecordCountLog(TotalCount)
VALUES (@TotalRecords)
GO
