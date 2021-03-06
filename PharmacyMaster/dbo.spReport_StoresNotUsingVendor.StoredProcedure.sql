USE [PharmacyMaster]
GO
/****** Object:  StoredProcedure [dbo].[spReport_StoresNotUsingVendor]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Chris Stone>
-- Create date: <04/12/2013>
-- Description:	Returns a list of stores that did not purchase from a given vendor in the given time period.
-- =============================================
CREATE PROCEDURE [dbo].[spReport_StoresNotUsingVendor] (@vendorid int, @fromdt datetime, @todt datetime)
AS
BEGIN
if (@todt >=  @fromdt)
	Select PMID,AccountName,city,state,zip  from v_AAPCurrentMemberList WHERE PMID  NOT IN (SELECT  PMID FROM  v_VendorVolumeRebate
	WHERE     VendorID = @vendorID AND (AccruedStartDt <= @todt and  AccruedEndDt >= @fromdt)
	GROUP BY PMID)
else 
	Select PMID,AccountName,city,state,zip  from v_AAPCurrentMemberList WHERE PMID  NOT IN (SELECT  PMID FROM  v_VendorVolumeRebate
	WHERE     VendorID = @vendorID AND (AccruedStartDt <= @fromdt and  AccruedEndDt >= @todt)
	GROUP BY PMID)
END
GO
