USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_update_PM_VendorAccts]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <04/23/2010>
-- Description:	UPdate PM_VendorAccts table
-- Modified 04/30/2010 to add API Info from PM_Pharmacy
-- =============================================
CREATE PROCEDURE [dbo].[sppm_update_PM_VendorAccts]

AS
BEGIN
 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table
-- Update/Create the Vendor Acct Table

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_VendorAccts_bkp')
          DROP TABLE PM_VendorAccts_bkp

	SELECT * into PM_VendorAccts_bkp from PM_VendorAccts

   IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_VendorAccts')
          DROP TABLE PM_VendorAccts



SELECT * INTO PM_VendorAccts FROM (
   SELECT * FROM (
		SELECT (SELECT pmid from pharmacymaster..pm_pharmacy  where dea = aapc.dea) as PMID, 
		v.vendorid as VendorID,case accounttype when 'PRIMARY' then 1 ELSE 0 end as isPrimary,wholesaleracctnum as VendAcctNum,   
		cast(null as varchar(30)) as PVA,cast(null as varchar(50)) as PaymentTerms,cast('AAP' as varchar(3)) as Source

		FROM aap..aapaccount aapc
		left outer join 
		(
		SELECT * FROM 
		aap..aapwholesalerstore
		) aapw on aapc.accountid = aapw.accountid
		left outer join
		(
		SELECT * FROM
		pharmacymaster..oldnewvendorslink
		) onv
		on onv.oldvendorid = aapw.wholesalerid or onv.vendorpair = aapw.wholesalerid
		left outer join
		(
		SELECT * FROM
		 pharmacymaster..Pm_Vendors
		) v on v.vendorid = onv.vendorid
		where v.vendorname = 'CARD'

       -- Added to include API
       UNION ALL
       SELECT PMID,
		 (select vendorid from PM_Vendors where vendorname = 'CARD') as VendorID,'1' as isPrimary,PrimaryCAAccountNo as VendAcctNum,   
		cast(null as varchar(30)) as PVA,cast(null as varchar(50)) as PaymentTerms,cast('API' as varchar(3)) as Source

		from pharmacymaster..pm_pharmacy where apiaccountno is not null 
          and PrimaryCAAccountNo is not null
	)ch
		where pmid is not null group by  vendacctnum , pmid,isPrimary,vendorid ,PVA,Source,PaymentTerms
)tmp 

	IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_VendorDC_bkp')
          DROP TABLE PM_VendorDC_bkp

	SELECT * into PM_VendorDC_bkp from PM_VendorDC

    IF EXISTS(SELECT name FROM sys.tables
        WHERE name = 'PM_VendorDC')
          DROP TABLE PM_VendorDC

--Update /Create the VendorDC file

SELECT * INTO PM_VendorDC FROM ( 
 SELECT * FROM (
		SELECT (SELECT pmid from pharmacymaster..pm_pharmacy  where dea = aapc.dea) as PMID, 
		v.vendorid as VendorID,case accounttype when 'PRIMARY' then 1 ELSE 0 end as isPrimary,wholesaleracctnum as VendAcctNum, dcnum as DCNum,
		cast('AAP' as varchar(3)) as Source

		FROM aap..aapaccount aapc
		left outer join 
		(
		SELECT * FROM 
		aap..aapwholesalerstore
		) aapw on aapc.accountid = aapw.accountid
		left outer join
		(
		SELECT * FROM
		pharmacymaster..oldnewvendorslink
		) onv
		on onv.oldvendorid = aapw.wholesalerid or onv.vendorpair = aapw.wholesalerid
		left outer join
		(
		SELECT * FROM
		 pharmacymaster..Pm_Vendors
		) v on v.vendorid = onv.vendorid
		where v.vendorname = 'CARD'
        --Added to include API
    UNION ALL
    SELECT PMID,
		 (SELECT vendorid from PM_Vendors where vendorname = 'CARD') as VendorID,'1' as isPrimary,PrimaryCAAccountNo as VendAcctNum,   
		  d.dcNum as DCNum,cast('API' as varchar(3)) as Source

		 FROM pharmacymaster..pm_pharmacy p
         left outer join PM_CardinalDCs d on p.CardinalDC = d.DCName
         WHERE apiaccountno is not null 
          and PrimaryCAAccountNo is not null
	)ch
		where pmid is not null and dcnum is not null group by  vendacctnum ,dcnum, pmid,isPrimary,vendorid ,Source 
)tmp

-- Update the PVA and Payment Terms from Cardinal File 

	   UPDATE  su  set 
			PVA =  ch.PVA ,
			PaymentTerms =  ch.PaymentTerms
	   FROM PM_VendorAccts su 
		inner join 
			(  select c.contract as PVA,c.[AR2000TermsCode] as PaymentTerms ,CAAccountNo from PM_VendorAccts v
				join (
				select * from PM_CHAccounts 
				) c on v.vendacctnum = c.CAAccountNo ) ch
	   on su.vendacctnum = ch.CAAccountNo
 
END








GO
