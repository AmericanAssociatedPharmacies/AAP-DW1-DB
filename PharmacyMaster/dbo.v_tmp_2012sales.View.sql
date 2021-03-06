USE [PharmacyMaster]
GO
/****** Object:  View [dbo].[v_tmp_2012sales]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_tmp_2012sales]
as
select
pmid,sum(WHAPITotal) as WHAPITotal, 
sum(CombNetSales) as CombNetSales
from all_volume
where [date]>='1/1/2012' and [date]<'1/1/2013'
group by PMID
GO
