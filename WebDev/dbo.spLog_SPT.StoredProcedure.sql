USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spLog_SPT]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc
[dbo].[spLog_SPT]
(
@button varchar(50)
,@login varchar(50)
,@pmid int
,@userrole varchar(15)
)
as
begin
insert into Log_SPT (
button
,login
,pmid
,date_accessed
,userrole
)
values(@button,@login,@pmid,getdate(),@userrole)
end
GO
