USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[rpt_AAPListing]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Rudy Hinojosa
-- Create date: 7-16-2010
-- Description:	AAP Listing
-- DIRECTLY MODIFYING THIS STORED PROCEDURE'S NUMBER OF COLUMNS WILL AFFECT THE
-- PHARMACY MASTER REPORTING ENGINE
-- =============================================
CREATE PROCEDURE [dbo].[rpt_AAPListing] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select p.pmid,p.aapaccountno,p.dea,p.accountname,p.resigned,
convert(varchar(10),p.aapquitdate,101) AS AAPQUITDATE,
convert(varchar(10),mc.mcquitdate,101) as MCQUITDATE ,
p.territory,am.city,am.state,
case isnull(mc.chaincode,0) when 0 then 'N' ELSE 'Y' END AS 'Managed Care',
case isnull(iswarehouse,0) when 0 then 'N' ELSE 'Y' END AS 'Warehouse',
case isnull(ispva,0) when 0 then 'N' ELSE 'Y' END AS 'PVA',
case isnull(isbuyinggroup,0) when 0 then 'N' ELSE 'Y' END AS 'Buying Group',
case isnull(ispos,0) when 0 then 'N' ELSE 'Y' END AS 'POS',
case isnull(isnpp,0) when 0 then 'N' ELSE 'Y' END AS 'Non Participating Pharmacy'
from pm_pharmacy p LEFT JOIN 
pm_managedcare mc on mc.pmid = p.pmid and mc.mcquitdate is null left join
pm_addressmaster am on am.pmid = p.pmid and am.address_type_id = 1
where ((p.resigned = 'N' or p.resigned is null ) and (aapquitdate is null or aapquitdate = '')) and p.aapaccountno is not null 
order by p.aapaccountno
END





GO
