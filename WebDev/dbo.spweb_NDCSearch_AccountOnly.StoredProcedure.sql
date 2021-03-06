USE [WebDev]
GO
/****** Object:  StoredProcedure [dbo].[spweb_NDCSearch_AccountOnly]    Script Date: 12/22/2020 8:09:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spweb_NDCSearch_AccountOnly]
(
@APIAccount varchar(25),
@Drugname varchar(50)
)
as
begin
select distinct 'yes' as ordered,
ndc_orig as ndc,itemdescription,APIItemNbr 
from api..apisalesdetail 
where itemdescription like '%' + @Drugname + '%' 
and whaccountid=@APIAccount and ndc_orig is not null 
and ndc_orig<> ''
order by itemdescription
end



GO
