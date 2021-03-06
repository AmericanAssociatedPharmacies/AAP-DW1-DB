USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[sp_loadPPEligibility]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:	CHANDNI KL
-- Create date: 05/05/2015
-- Description:	Populates PMID in [dbo].PPELIGIBILITY
-- =============================================
CREATE PROCEDURE [dbo].[sp_loadPPEligibility] 

AS
BEGIN

truncate table tempPMID
insert into tempPMID SELECT t.accountno,t.pmid from PPEligibility p join( SELECT * from pharmacymaster..pm_chaccounts_adj
	UNPIVOT
	(
	  AccountNo for details in 
	  (
	  chaccountnoprimary,
	 chaccountno2,
	 chaccountno3,
	 CSOSAcct,
	 POSAcct,
	 ScanTossAcct,
	 SecondPrimaryNumber,
	 Second2nd,
	 Second3rd,
	 SecondPOS,
	 SecondCSOS,
	 SecondCST,
	 ThirdPrimaryNumber,
	 Third2nd,
	 ThirdPOS,
	 ThirdCSOS,
	 ThirdCST
	 )
	) as UnPvt
) t on SUBSTRING(t.accountno,1,len(t.accountno)- PATINDEX('%[0-9]%', reverse(t.accountno))+1 ) = p.CustomerNumber  

UPDATE PPEligibility SET PPEligibility.PMID = t.pmid FROM PPEligibility p INNER JOIN tempPMID t
ON p.CustomerNumber = SUBSTRING(t.accountno,1,len(t.accountno)- PATINDEX('%[0-9]%', reverse(t.accountno))+1 )

END

GO
