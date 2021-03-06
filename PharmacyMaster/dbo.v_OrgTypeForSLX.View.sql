USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_OrgTypeForSLX]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_OrgTypeForSLX]
AS
SELECT aapaccountno ,apiaccountno,dea,description from pm_pharmacy p
left outer join
(
	SELECT * from pm_organizationtypes
) o on p.organizationtype = o.id where  p.organizationtype is not null and  p.organizationtype != ''
GO
