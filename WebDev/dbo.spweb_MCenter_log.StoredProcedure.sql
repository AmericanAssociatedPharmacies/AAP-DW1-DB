USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_MCenter_log]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spweb_MCenter_log]
(
	@messageid int,
	@login varchar(50),
	@pmid int,
	@userrole varchar(50)
)
as
begin
insert into messagecenter_log (messageid,login,pmid,date_read,userrole)
values(@messageid,@login,@pmid,getdate(),@userrole)
end
GO
