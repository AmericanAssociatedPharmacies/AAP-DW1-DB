USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_findPMID]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spweb_findPMID]
	@search varchar(255)
AS

	select max(v.PMID) as PMID
		from pharmacymaster..v_pm_allwithaffiliates v 
		where 
			convert(varchar(6),v.pmid)=@search
			or v.aapaccountno=@search
			or v.apiaccountno=@search
			or v.ncpdp=@search
GO
