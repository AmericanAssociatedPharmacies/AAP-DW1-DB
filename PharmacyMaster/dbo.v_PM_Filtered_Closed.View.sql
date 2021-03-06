USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_PM_Filtered_Closed]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_PM_Filtered_Closed]
AS

SELECT *from pm_pharmacy p
where   ((businessclass  != 'CZZ'   )
or ((businessclass    = 'CZZ' or businessclass is null)
 and  ((aapaccountno is   null and (udaccountno is not null and ( udquitdate is null))) or (aapaccountno is not  null )) ))  

-- The filter may seem a little crazy but I had to account for that fact that an aapaccount or udaccount may be valid even it the api account is 'CZZ'
 
-- THIS WILL GIVE SAME RESULTS - A LITTLE EASIER TO READ
--select * from pm_pharmacy where  (businessclass    != 'CZZ'  
--or businessclass is null)
--and udaccountno is not null and (udquitdate > '12/31/2008' or udquitdate is null)
--union
--select * from pm_pharmacy where  (businessclass    != 'CZZ'  
--or businessclass is null)
--and aapaccountno is not null
--union 
--select * from  pm_pharmacy where 
--(businessclass    != 'CZZ'  
--or businessclass is null) and (apiaccountno is not null)
GO
