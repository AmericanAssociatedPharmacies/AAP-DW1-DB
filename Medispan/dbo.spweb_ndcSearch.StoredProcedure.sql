USE [Medispan]
GO
/****** Object:  StoredProcedure [dbo].[spweb_ndcSearch]    Script Date: 12/22/2020 7:12:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[spweb_ndcSearch]
(
@APIAccount varchar(25),
@Drugname varchar(50)
)
as
begin
select distinct
top 1000 
v.ndc,v.drugname,v.mfg,
case when dt.ndc is null then '' else APIItemNbr end as APIItemNbr,
case when dt2.ndc is null then '' else 'yes' end as Ordered
from medispan..v_drugmaster v
left join
(select distinct ndc,APIItemNbr,Description
from claims..apiprice
where dateloaded = (select max(dateloaded) from claims..apiprice)
) dt on dt.ndc=v.ndc
left join
(select distinct ndc from api..apisalesdetail a
where whaccountid=@APIAccount) dt2 on dt2.ndc=v.ndc
where v.obsdtec is null
--and APIItemNbr is not null
and (drugname like '%' + @Drugname + '%') -- or dt.Description like '%' + @Drugname + '%')
order by ordered desc,
drugname,ndc
end
--spweb_ndcSearch '01190120','oxycod'

GO
