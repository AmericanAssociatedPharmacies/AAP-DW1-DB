USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[rpt_ManagedCareCredentialing]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: 7-9-2010
-- Description:	Managed Care Credentialing Report
-- DIRECTLY MODIFYING THIS STORED PROCEDURE'S NUMBER OF COLUMNS WILL AFFECT THE
-- PHARMACY MASTER REPORTING ENGINE
-- =============================================
CREATE PROCEDURE [dbo].[rpt_ManagedCareCredentialing] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    
	--credentialing report for linda jensen
select genliabcarrier,CONVERT(varchar(10), geninsexpdate, 101) as geninsexpdate,profliabcarrier,CONVERT(varchar(10), profliabinsexpdate, 101) as profliabinsexpdate,
statelicno,CONVERT(varchar(10), statelicexpdate, 101) as statelicexpdate,p.pharfullname,p.pharlicno,CONVERT(varchar(10), pharexpdate, 101) as pharexpdate,
m.dea,CONVERT(varchar(10), m.deaexp, 101) as deaexp,M.AccountName,M.NCPDP,am.phone,am.fax,am.state,m.aapaccountno
from pm_cred c left outer join 
pm_pharmacists p on c.pmid = p.pmid left outer join
pm_pharmacy m on c.pmid = m.pmid left outer join
pm_addressmaster am on c.pmid = am.pmid and am.address_type_id = 1
where c.pmid in (select pmid from pm_managedcare where chaincode is not null)
order by am.state,m.accountname
END





GO
