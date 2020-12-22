USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spMCenter_list111814]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc
[dbo].[spMCenter_list111814]
(
@PMID int
) 
as
declare @buf int
select @buf=PMID
from MCenter_list111814 where pmid=@pmid
select case when @buf is null then 0 else 1 end as result
GO
