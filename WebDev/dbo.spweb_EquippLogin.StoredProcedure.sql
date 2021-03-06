USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_EquippLogin]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Vrindha Nair>
-- Create date: <10-20-2014>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spweb_EquippLogin]
@NPI varchar(15)


AS
BEGIN
/*
SELECT  [New Username] as [UserName], 
[Initial Password] as [Password]
FROM 
PharmacyMaster..EquippUserList 
WHERE [level of access npi]=@NPI
*/
select 
u.[New Username] as [UserName], 
u.[Initial Password] as [Password], 
CASE WHEN h.NPI is NULL THEN '0' ELSE '1' END AS [Logged In Record],
u.[Level of Access/NPI] as [NPI]
from PharmacyMaster..EquippUserList u 
LEFT JOIN PharmacyMaster..EquippLoginHistory h on h.npi = u.[Level of Access/NPI]
where u.[Level of Access/NPI]=@NPI
ORDER by NPI

END
/*
select * from PharmacyMaster..EquippUserList  where [level of access npi]= '1972524932'
[spweb_EquippLogin] '1972524932'

--select 
--u.[New Username] as [UserName], 
--u.[Initial Password] as [Password], 
--CASE WHEN h.NPI is NULL THEN '0' ELSE '1' END AS [Logged In Record],
--u.[Level of Access NPI] as [NPI]
--from PharmacyMaster..EquippUserList u 
--LEFT JOIN PharmacyMaster..EquippLoginHistory h on h.npi = u.[level of access npi]
--ORDER by NPI


select * from PharmacyMaster..EquippLoginHistory
*/
GO
