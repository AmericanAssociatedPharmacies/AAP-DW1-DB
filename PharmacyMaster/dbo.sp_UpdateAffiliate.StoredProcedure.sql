USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAffiliate]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- =============================================
-- Author:		Chandni Lyla
-- Create date: 4/13/2015
-- Description:	Adds new affiliate entered through the intranet page
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateAffiliate] 
	@AccountName VARCHAR(65), 
	@Addr1 VARCHAR(80),
	@Addr2 VARCHAR(80),
	@City VARCHAR(25), 
	@State VARCHAR(2),
    @Zip varchar(10),
	@ContactFullName varchar(255),
	@Phone varchar(50),
	@Fax varchar(50),
	@Email varchar(80),
    @CorpId int

	 AS 
BEGIN 
	Update PM_Corporate set AccountName=@AccountName, Addr1=@Addr1,Addr2=@Addr2,City=@City,State=@State,Zip=@Zip,ContactFullName=@ContactFullName,Phone=@Phone,Fax=@Fax,Email=@Email where CorpID=@CorpId 
   

END
--exec sp_UpdateAffiliate 'test  test','ad1','a2','c','s','z','fn','ph','fx','em','test3'
GO
