USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spContact_AAPBOD]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spContact_AAPBOD]
as
select * from
(
select 
distinct Name,Title,Phone,Email 
from pharmacymaster..aap_bod
) dt
order by Title
,case when charindex(' ',Name) = 0 then Name else substring(name,charindex(' ',Name)+1,1000) end 
GO
