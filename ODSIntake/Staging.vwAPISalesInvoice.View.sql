USE [ODSIntake]
GO
/****** Object:  View [Staging].[vwAPISalesInvoice]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [Staging].[vwAPISalesInvoice]

AS

SELECT CONVERT(VARCHAR(32), CASE 
						    WHEN Invoice NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE Invoice
							END
							) AS InvNbr
	 , CONVERT(VARCHAR(15), CASE 
							WHEN OrderNbr NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE OrderNbr
							END
							) AS OrderNbr
	 , CONVERT(datetime, Date) AS InvDate
	 , CONVERT(VARCHAR(32), CASE 
							WHEN APICustNbr NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE APICustNbr
							END 
							) AS WHAccountID
	 , CONVERT(VARCHAR(255), CASE 
							 WHEN APICustName NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE APICustName
							 END
							 ) AS CustomerName
	 , CONVERT(VARCHAR(15), CASE 
							WHEN CarrierCode NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							ELSE CarrierCode
							END
							) AS CarrierCode
	 , CONVERT(VARCHAR(255), CASE 
							 WHEN CarrierDesc NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE CarrierDesc
							 END
							 ) AS CarrierDesc
	 , CONVERT(VARCHAR(255), CASE
							 WHEN CustRef NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
							 ELSE CustRef
							 END
							 ) AS CustomerRef
	 , CONVERT(VARCHAR(2), CASE
						   WHEN Whse NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
						   ELSE Whse
						   END
						   ) AS Whsnum
	 , CONVERT(VARCHAR(2), CASE	
						   WHEN OrdType NOT LIKE '%[a-zA-Z0-9]%' THEN NULL
						   ELSE OrdType
						   END
						   ) AS OrdType
FROM [Staging].[APIInvoiceImport]
GO
