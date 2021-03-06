USE [WebDev]
GO
/****** Object:  View [dbo].[v_DCAll]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Patrick
-- Create date: 
-- Description:	
-- =============================================
CREATE view [dbo].[v_DCAll]
as
select
NDC
,Drugname
,Grp#
,[Disp Fee]
,isnull([Unit Ing.Cost],AWP) as [Unit Ing.Cost]
,[Reimbursement Indicator]
,[Brand]
,[Non-MAC Generic]
,MAC
--,rank() over (partition by [ndc],
--,case when Unit Ing.Cost] is null then 'foobar'
--	else case if AWP is null then null else 'barfoo' end 
--	end as [Total Patient Pay]
from
(
select 
NDC
,Drugname
,Grp#
,[Disp Fee]
,[Unit Ing.Cost]
,null as AWP
,[Reimbursement Indictor] as [Reimbursement Indicator]
,[Brand]
,[Non-MAC Generic]
,MAC

from DCPriceWeb
union
select
NDC
,Drugname
,null as Grp#
,null as [Disp Fee]
,null as [Unit Ing.Cost]
,AWP
,[Reimbursement Indictor] as [Reimbursement Indicator]
,null as [Brand]
,null as [Non-MAC Generic]
,null as MAC

from DCNonMAC
union
select 
null as NDC
,null as Drugname
,Grp#
,[Disp Fee]
,null as [Unit Ing.Cost]
,null as AWP
,[Reimbursement Indictor] as [Reimbursement Indicator]
,[Brand]
,[Non-MAC Generic]
,MAC

from DCGroupsWeb
) dt
GO
