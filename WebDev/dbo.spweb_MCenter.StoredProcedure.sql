USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_MCenter]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spweb_MCenter]
(
	--unread or read messages for the pmid BG 10/25/13
	--"count" arg is deprecated. All unread messages are returned to website login_processor,
	--which applies filters by access_code or pmid fields
	@sswitch varchar(8),  
	@ipmid int
) as
begin
	if (@sswitch = 'unread')	
		begin
			select id,
				convert(varchar(10),date_posted,101) as date_posted,
				--convert(varchar(10),date_actionrequired,101) as date_actionrequired,
				title,link,description,access_codes,PMIDs,query_text
			from  messagecenter_messages
			where id not in
			(select messageid from messagecenter_log where pmid=@ipmid)
			and (date_expires is null or date_expires > getdate())
			order by messagecenter_messages.date_posted desc
		end
	else 
		begin
			if (@sswitch = 'read')
			begin
				select id,
				convert(varchar(10),date_posted,101) as date_posted,
				--convert(varchar(10),date_actionrequired,101) as date_actionrequired,
				title,link,description,access_codes,PMIDs,query_text
				from  messagecenter_messages
				where id in
				(select messageid from messagecenter_log where pmid=@ipmid)
				and (date_expires is null or date_expires > getdate())
				order by messagecenter_messages.date_posted desc
			end
			else 
			begin
				if (@sswitch = 'count') --of unread
				begin
					select count(1) as [number_unread] from  messagecenter_messages
					where id not in
					(select messageid from messagecenter_log where pmid=@ipmid)
					and  (date_expires is null or date_expires > getdate())
				end
				--else bad arg
			end
		end
end
GO
