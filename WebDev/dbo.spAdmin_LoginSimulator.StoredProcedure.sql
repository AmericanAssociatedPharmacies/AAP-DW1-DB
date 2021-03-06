USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spAdmin_LoginSimulator]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spAdmin_LoginSimulator]
as
begin

declare @iresult int,@iresult2 int,@iresult3 int
declare @pmid int
--set @pmid=0  --nonexistent value to cause a scan 
set @pmid=104339

--call loginValidate, suppress output
create table #tmp1 (retval int)
insert into #tmp1
exec @iresult = spweb_loginValidate_nolog '',''
drop table #tmp1

--call login description and programinfo
exec @iresult2 = spweb_loginDescription_byPMID @pmid
exec @iresult3 = spweb_programinfo @pmid

--return results
select @iresult as validate,@iresult2 as description,@iresult3 as programinfo

return 0
end
--grant exec on spAdmin_LoginSimulator to webdevuser
GO
