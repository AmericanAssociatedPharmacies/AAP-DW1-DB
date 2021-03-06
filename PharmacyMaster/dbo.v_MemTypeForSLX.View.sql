USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_MemTypeForSLX]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[v_MemTypeForSLX]
AS

SELECT aapaccountno ,apiaccountno,dea,description from pm_pharmacy p
left outer join
(
	SELECT * from PM_MembershipTypes
) o on p.MembershipType = o.id where  p.MembershipType is not null and  p.MembershipType != ''
GO
