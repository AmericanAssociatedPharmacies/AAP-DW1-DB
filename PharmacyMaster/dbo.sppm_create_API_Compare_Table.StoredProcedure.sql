USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_create_API_Compare_Table]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/14/2010>
-- Description:	Create Compare tables from the backups
-- =============================================
CREATE PROCEDURE [dbo].[sppm_create_API_Compare_Table]

AS
	BEGIN
 
 
-- Compare for API Data

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'tmp_CompareAPI')
          DROP TABLE tmp_CompareAPI
 

	SELECT * into tmp_CompareAPI from (

	SELECT MIN(TableName) as TableName,  count(*) 
	NDUPS,AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA
	FROM
	(

	  SELECT 'Outdated_APIData' as TableName, count(*) NDUPS, 	AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA

	  FROM pharmacymaster..v_SSIS_APICustomerList_Bkp A
		GROUP BY 
	AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA

	  UNION ALL

	  SELECT 'New_APIData' as TableName,  count(*) 
	NDUPS,AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA

	  FROM pharmacymaster..v_SSIS_APICustomerList  B
	   GROUP BY AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA
	) tmp

	GROUP BY  
	NDUPS,AccountNo,AccountName,Addr1,Addr2,City,State,Zip,ContactFullName,Territory,
	QPS,APIMemberNo,BusinessClass,Phone,Fax,Email,DateOpened,OrigStartDate,NumReactivated,
	Wholesaler,WholesalerAccountNo,DEA,DEAEXP,StateLicNo,StateLicExpDate,FedID,Status,CAHStatus,
	CardinalDC,PrimaryCAAccountNo,ContractDate,Source,CustPayTermsAPI,APIStatus,AllowDupDEA

	HAVING COUNT(*) = 1
	) tmp

END
GO
