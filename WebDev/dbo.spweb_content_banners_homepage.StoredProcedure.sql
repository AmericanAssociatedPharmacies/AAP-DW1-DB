USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_content_banners_homepage]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[spweb_content_banners_homepage]
as
begin
select id,imageURL,linkURL,description,externalLink,sortOrder
--dont return datetimes, php throws str_replace error
from content_banners_homepage
where (dateExpires is null or dateExpires > getdate())
and (dateStartDisplay is null or dateStartDisplay <= getdate())
--order by isnull(sortorder,999)
--changed 12/17/13, returns those with null sortorder in random order :) BG
order by isnull(right(replicate('0',36) + cast(sortorder as varchar(5)),36),newid()),id desc
end
	
GO
