USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spaap_UnpunctuateCorporateForIRS]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spaap_UnpunctuateCorporateForIRS]
as
BEGIN
--set nocount on
if exists (select * from sys.tables where name = 'pm_pharmacy_backup')
begin
	drop table pm_pharmacy_backup
end
select * into pm_pharmacy_backup from pm_pharmacy

if exists (select * from sys.tables where name = 'pm_addressmaster_backup')
begin
	drop table pm_addressmaster_backup
end
select * into pm_addressmaster_backup from pm_addressmaster

update pm_pharmacy
set 
	corporatename = dbo.csfn_stripPunctuationIRS(corporatename)

update pm_addressmaster
set 
	address = dbo.csfn_stripPunctuationIRS(address),
	address2 = dbo.csfn_stripPunctuationIRS(address2),
	city = dbo.csfn_stripPunctuationIRS(city),
	zip = dbo.csfn_stripPunctuationIRS(zip)
where address_type_id=3
--set nocount off
END
GO
