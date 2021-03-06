USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[sppm_prepare_PeachTreeTable]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		< Joni Wilson>
-- Create date: <03/29/2010>
-- Description:	Backup and Truncate AddressMaster to recreate
-- =============================================
CREATE PROCEDURE [dbo].[sppm_prepare_PeachTreeTable]

AS
BEGIN
 
--	select * into PM_PeachTree from (
--	select m.pmid,
--	case when m.corporatename is not null then m.corporatename else m.accountname end as Corpname,
--	a.address,a.address2,a.city,a.state,a.zip,'1'as [1099Type],a.phone,a.fax,m.email,'00-6550' as [GLExpenseAccount],m.FedID,'2' as [1099Setting]
--	 from aap..newpharmacymasterfortest m
--	left outer join
--	v_address_mailing a
--	on m.pmid = a.pmid 351120255
--	)tmp
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	   --- Drop the previous runs table


      Update tmp_Peachtree set FedID = substring(FedID,1,2) + '-' + substring(FedID,3,7) where charindex('-',FedID) = 0; -- add in dash if missing in FedID

      Update tmp_Peachtree set phone =   REPLACE(phone,'-',''); --Remove all hypens from phone

      Update tmp_Peachtree set phone = substring(phone,1,3) + '-' + substring(phone,4,7) -- add only one hyphen back in to phone

      Update tmp_Peachtree set fax = substring(fax,1,3) + '-' + substring(fax,4,7) -- add only one hyphen back in to phone
      Update tmp_Peachtree set fax = '' where fax = '-'; -- Need to get rid of these not sure where coming from - addressmaster - must look at this
      Update tmp_Peachtree set phone = '' where phone = '-'; -- Need to get rid of these not sure where coming from - addressmaster - must look at this
END








GO
